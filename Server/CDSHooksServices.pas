unit CDSHooksServices;

interface

uses
  SysUtils, Classes,
  IdContext,
  AdvGenerics, AdvJson,
  FHIRSupport, FHIRTypes, FHIRResources, FHIRUtilities,
  CDSHooksUtilities,
  CDSHooksServer, FHIRServerContext, FHIRStorageService;

type
  TCDAHooksCodeViewService = class (TCDSHooksService)
  public
    function hook : string; override;
    function name : String; override;
    function description : String; override;

    function HandleRequest(server: TFHIRServerContext; secure : boolean; session : TFHIRSession; context: TIdContext; request: TCDSHookRequest) : TCDSHookResponse; override;
  end;

  TCDAHooksIdentifierViewService = class (TCDSHooksService)
  private
    procedure addNamingSystemInfo(ns: TFHIRNamingSystem; baseURL : String; resp: TCDSHookResponse);
    procedure addSystemCard(resp: TCDSHookResponse; name, publisher, responsible, type_, usage, realm: String);
  public
    function hook : string; override;
    function name : String; override;
    function description : String; override;

    function HandleRequest(server: TFHIRServerContext; secure : boolean; session : TFHIRSession; context: TIdContext; request: TCDSHookRequest) : TCDSHookResponse; override;
  end;

  TCDAHooksPatientViewService = class (TCDSHooksService)
  private
    function identifyPatient(engine : TFHIROperationEngine; session : TFHIRSession; context: TIdContext; request: TCDSHookRequest; var needSecure : boolean) : TFHIRPatient;
    function buildPatientView(server: TFHIRServerContext; engine : TFHIROperationEngine; base : String; secure : boolean; patient : TFHIRPatient; session : TFHIRSession) : TCDSHookResponse;
  public
    function hook : string; override;
    function name : String; override;
    function description : String; override;

    function HandleRequest(server: TFHIRServerContext; secure : boolean; session : TFHIRSession; context: TIdContext; request: TCDSHookRequest) : TCDSHookResponse; override;
  end;

  TCDAHackingHealthOrderService = class (TCDSHooksService)
  private
    function check(issues : TStringList; condition : boolean; message : String) : boolean;
  public
    function hook : string; override;
    function name : String; override;
    function id : String; override;
    function description : String; override;
    procedure registerPreFetch(json : TJsonObject); override;

    function HandleRequest(server: TFHIRServerContext; secure : boolean; session : TFHIRSession; context: TIdContext; request: TCDSHookRequest) : TCDSHookResponse; override;
  end;

implementation

{ TCDAHooksCodeViewService }

function TCDAHooksCodeViewService.name: String;
begin
  result := 'code-view';
end;

function TCDAHooksCodeViewService.description: String;
begin
  result := 'View details about a code';
end;

function TCDAHooksCodeViewService.HandleRequest(server: TFHIRServerContext; secure: boolean; session: TFHIRSession; context: TIdContext; request: TCDSHookRequest): TCDSHookResponse;
var
  params: TFHIRParameters;
  code : TFhirType;
  card : TCDSHookCard;
begin
  require((request.context.Count = 1) and (request.context[0] is TFhirParameters), 'Must have a single parameters resource as the context');
  params := request.context[0] as TFhirParameters;
  code := params.NamedParameter['code'] as TFHIRType;
  require(code <> nil, 'No "code" parameter found');
  require((code is TFHIRCoding) or (code is TFHIRCodeableConcept), '"code" parameter has wrong type '+code.fhirType);
  result := TCDSHookResponse.Create;
  try
    if code is TFhirCoding then
      server.TerminologyServer.getCodeView(request.Lang, code as TFHIRCoding, result)
    else
      server.TerminologyServer.getCodeView(request.Lang, code as TFHIRCodeableConcept, result);
    for card in result.cards do
    begin
      card.sourceLabel := server.OwnerName;
      card.sourceURL := request.baseUrl;
      card.indicator := 'info';
    end;
    result.Link;
  finally
    result.Free;
  end;
end;


function TCDAHooksCodeViewService.hook: string;
begin
  result := 'code-view';
end;

{ TCDAHackingHealthOrderService }

function TCDAHackingHealthOrderService.check(issues: TStringList; condition: boolean; message: String): boolean;
begin
  if not condition then
    issues.Add(message);
  result := condition;
end;

function TCDAHackingHealthOrderService.description: String;
begin
  result := 'Implements the Hacking Health interface. This simply inspects the call and returns a card that evaluates the completeness of the information provided';
end;

function TCDAHackingHealthOrderService.hook: string;
begin
  result := 'order-review';
end;

function TCDAHackingHealthOrderService.id: String;
begin
  result := 'hacking-health';
end;

function TCDAHackingHealthOrderService.name: String;
begin
  result := 'Hacking Health';
end;

procedure TCDAHackingHealthOrderService.registerPreFetch(json: TJsonObject);
var
  pf : TJsonObject;
begin
  pf := json.forceObj['prefetch'];
  pf.str['patient'] := 'Patient/{{Patient.id}}';
  pf.str['encounter'] := 'Encounter/{{Encounter.id}}';
  pf.str['problems'] := 'Condition?patient={{Patient.id}}&_list=$current-problems';
end;

function TCDAHackingHealthOrderService.HandleRequest(server: TFHIRServerContext; secure: boolean; session: TFHIRSession; context: TIdContext; request: TCDSHookRequest): TCDSHookResponse;
var
  issues : TStringList;
  res : TFHIRResource;
  pr : TFhirProcedureRequest;
  be : TFhirBundleEntry;
  c : TFhirCondition;
  card : TCDSHookCard;
  b : TStringBuilder;
  s : String;
  e : TFhirEncounter;
begin
  issues := TStringList.create;
  try
    check(issues, request.hook = Self.hook, 'hook must be '+self.hook+' but is '+request.hook);
    check(issues, request.hookInstance <> '', 'hookInstance must be provided');
    check(issues, request.fhirServer = '', 'fhirServer must be blank (no call back to EHR for Hacking Health)');
    check(issues, request.oauth = nil, 'oAuth should not be present (no call back to EHR for Hacking Health)');
    check(issues, request.redirect = '', 'redirect must be blank (no call back to EHR for Hacking Health)');
    check(issues, request.user <> '', 'user must not be blank (want user id - for consistency?)');
    check(issues, request.patient <> '', 'patient is required');
    check(issues, request.encounter <> '', 'encounter is required');
    check(issues, request.context.Count > 0, 'at least one resource is required in context');
    {$IFNDEF FHIR2}
    for res in request.context do
    begin
      if check(issues, res.ResourceType = frtProcedureRequest, 'Context resources must be a ProcedureRequest') then
      begin
        pr := res as TFhirProcedureRequest;
        if check(issues, (pr.subject <> nil) and (pr.subject.reference <> ''), 'ProcedureRequest must have a subject') then
          check(issues, pr.subject.reference = request.patient, 'ProcedureRequest subject must match request.subject');
        if check(issues, (pr.context <> nil) and (pr.context.reference <> ''), 'ProcedureRequest must have a context') then
          check(issues, pr.context.reference = request.encounter, 'ProcedureRequest context must match request.encounter');
        check(issues, pr.code <> nil, 'ProcedureRequest must have a code');
      end;
    end;

    if check(issues, request.prefetch.ContainsKey('patient'), 'A patient must be present in the prefetch data') then
    begin
      check(issues, request.preFetch['patient'].ResourceType = frtPatient, 'Patient resource must be a patient');
      check(issues, request.patient = 'Patient/'+request.preFetch['patient'].id, 'Patient resource id must match patient in request');
    end;
    if check(issues, request.prefetch.ContainsKey('encounter'), 'An encounter must be present in the prefetch data') then
    begin
      if check(issues, request.preFetch['encounter'].ResourceType = frtEncounter, 'Patient encounter must be an encounter') then
      begin
        check(issues, request.encounter = 'Encounter/'+request.preFetch['encounter'].id, 'Encounter resource id must match encounter in request');
        e := TFhirEncounter(request.preFetch['encounter']);
        if check(issues, (e.subject <> nil) and (e.subject.reference <> ''), 'Encounter must have a subject') then
          check(issues, e.subject.reference = request.patient, 'Encounter subject must match request.subject');
      end;
    end;
    if check(issues, request.prefetch.ContainsKey('problems'), 'A problems list must be present in the prefetch data') then
      if check(issues, request.preFetch['problems'].ResourceType = frtBundle, 'Problems List must be a bundle') then
        for be in TFHIRBundle(request.preFetch['problems']).entryList do
          if check(issues, be.resource <> nil, 'Problem List Bundle Entries must have a resource') and
            check(issues, be.resource is TFhirCondition, 'problems must be a condition') then
          begin
            c := be.resource as TFhirCondition;
            if check(issues, (c.subject <> nil) and (c.subject.reference <> ''), 'Condition must have a subject') then
              check(issues, c.subject.reference = request.patient, 'Condition subject must match request.subject');
            check(issues, c.code <> nil, 'Condition must have a code');
          end;
    {$ENDIF}
    result := TCDSHookResponse.Create;
    card := Result.addCard;
    if issues.Count = 0 then
    begin
      card.summary := 'order-review request is ok';
      card.detail := 'All tests passed';
      card.indicator := 'success';
    end
    else
    begin
      card.summary := 'order-review request: '+inttostr(issues.Count)+' issues found';
      b := TStringBuilder.Create;
      try
        for s in issues do
          b.Append('* '+s+#13#10);
        card.detail := b.ToString;
      finally
        b.Free;
      end;
      card.indicator := 'warning';
    end;
  finally
    issues.Free;
  end;
end;

{ TCDAHooksIdentifierViewService }

function TCDAHooksIdentifierViewService.description: String;
begin
  result := 'View details about an identifier';
end;

procedure TCDAHooksIdentifierViewService.addSystemCard(resp: TCDSHookResponse; name, publisher, responsible, type_, usage, realm : String);
var
  card : TCDSHookCard;
  b : TStringBuilder;
begin
  card := resp.addCard;
  b := TStringBuilder.Create;
  try
    b.append('* Identifier System Name: '+name+#13#10);
    if publisher <> '' then
      b.append('* Publisher: '+publisher+#13#10);
    if responsible <> '' then
      b.append('* Responsible: '+responsible+#13#10);
    if type_ <> '' then
      b.append('* Type: '+type_+#13#10);
    if usage <> '' then
      b.append('* Usage Notes: '+usage+#13#10);

    b.append(#13#10);

    if realm > '' then
    begin
      b.Append('Contexts of Use'#13#10#13#10);
      b.Append('* '+realm+#13#10);
      b.append(#13#10);
    end;

    card.detail := b.ToString;
  finally
    b.Free;
  end;

end;

procedure TCDAHooksIdentifierViewService.addNamingSystemInfo(ns: TFHIRNamingSystem; baseURL : String; resp: TCDSHookResponse);
var
  card : TCDSHookCard;
  b : TStringBuilder;
  cp : TFhirNamingSystemContact;
  {$IFNDEF FHIR2}
  uc : TFhirUsageContext;
  {$ENDIF}
  cc : TFhirCodeableConcept;
begin
  card := resp.addCard;
  card.addLink('Further Detail', baseURL+'/open/NamingSystem/'+ns.id);
  b := TStringBuilder.Create;
  try
    b.append('* Identifier System Name: '+ns.name+#13#10);
    if ns.publisher <> '' then
      b.append('* Publisher: '+ns.publisher+#13#10);
    if ns.responsible <> '' then
      b.append('* Responsible: '+ns.responsible+#13#10);
    if ns.type_ <> nil then
      b.append('* Type: '+gen(ns.type_)+#13#10);
    if ns.usage <> '' then
      b.append('* Usage Notes: '+ns.usage+#13#10);

    b.append(#13#10);

    if (ns.useContextList.Count > 0) {$IFNDEF FHIR2}or (ns.jurisdictionList.Count > 0){$ENDIF} then
    begin
      b.Append('Contexts of Use'#13#10#13#10);
      {$IFNDEF FHIR2}
      for uc in ns.useContextList do
        b.Append('* '+gen(uc.code)+':'+gen(uc.value)+#13#10);
      for cc in ns.jurisdictionList do
        b.Append('* Jurisdiction: '+gen(cc)+#13#10);
      {$ELSE}
      for cc in ns.useContextList do
        b.Append('* '+gen(cc)+#13#10);
      {$ENDIF}
      b.append(#13#10);
    end;

    if ns.contactList.Count > 0 then
    begin
      b.Append('Contacts'#13#10#13#10);
      for cp in ns.contactList do
        b.Append('* '+cp.name+#13#10);
      b.append(#13#10);
    end;
    card.detail := b.ToString;
  finally
    b.Free;
  end;
end;

function TCDAHooksIdentifierViewService.HandleRequest(server: TFHIRServerContext; secure: boolean; session: TFHIRSession; context: TIdContext; request: TCDSHookRequest): TCDSHookResponse;
var
  params: TFHIRParameters;
  id : TFhirIdentifier;
  systems : TAdvList<TFHIRResource>;
  card : TCDSHookCard;
  engine : TFHIROperationEngine;
  needSecure: boolean;
  r : TFhirResource;
begin
  require((request.context.Count = 1) and (request.context[0] is TFhirParameters), 'Must have a single parameters resource as the context');
  params := request.context[0] as TFhirParameters;
  require(params.NamedParameter['identifier'] <> nil, 'No "identifier" parameter found');
  require((params.NamedParameter['identifier'] is TFHIRIdentifier), '"identifier" parameter has wrong type '+params.NamedParameter['identifier'].fhirType);
  id := params.NamedParameter['identifier'] as TFHIRIdentifier;
  result := TCDSHookResponse.Create;
  try
    if (id.type_ <> nil) then
      server.TerminologyServer.getCodeView(request.Lang, id.type_, result);

    if (id.system <> '') then
    begin
      engine := server.Storage.createOperationContext(request.lang);
      try
        systems := engine.getResourcesByParam(frtNamingSystem, 'value', id.system, needSecure);
        try
          for r in systems do
            addNamingSystemInfo(r as TFHIRNamingSystem, request.baseUrl, result);
        finally
          systems.Free;
        end;

      finally
        server.Storage.Yield(engine, nil);
      end;
    end;
    if (id.system = 'urn:ietf:rfc:3986') then
      addSystemCard(result, 'URI', '', 'W3C', '(any)', 'For when the identifier is any valid URI', '');

    for card in result.cards do
    begin
      card.sourceLabel := server.OwnerName;
      card.sourceURL := request.baseUrl;
      card.indicator := 'info';
    end;
    result.Link;
  finally
    result.Free;
  end;
end;

function TCDAHooksIdentifierViewService.hook: string;
begin
  result := 'identifier-view';
end;

function TCDAHooksIdentifierViewService.name: String;
begin
  result := 'identifier-view';
end;

{ TCDAHooksPatientViewService }

function TCDAHooksPatientViewService.description: String;
begin
  result := 'return details about the patient';
end;

function TCDAHooksPatientViewService.hook: string;
begin
  result := 'patient-view';
end;

function TCDAHooksPatientViewService.name: String;
begin
  result := 'patient-view';
end;

function TCDAHooksPatientViewService.HandleRequest(server: TFHIRServerContext; secure: boolean; session: TFHIRSession; context: TIdContext; request: TCDSHookRequest): TCDSHookResponse;
var
  engine : TFHIROperationEngine;
  patient : TFHIRPatient;
  needSecure : boolean;
begin
  engine := server.Storage.createOperationContext(request.lang);
  try
    patient := identifyPatient(engine, session, context, request, needSecure);
    try
      if (patient <> nil) and (secure or not needSecure) then
        result := buildPatientView(server, engine, request.baseURL, secure, patient, session)
      else
        result := nil;
    finally
      patient.Free;
    end;
  finally
    server.Storage.Yield(engine, nil);
  end;
end;

function TCDAHooksPatientViewService.identifyPatient( engine: TFHIROperationEngine; session: TFHIRSession; context: TIdContext; request: TCDSHookRequest; var needSecure: boolean): TFHIRPatient;
var
  key : integer;
  res : TFHIRResource;
  pat : TFhirPatient;
  be : TFhirBundleEntry;
  matches, m : TMatchingResourceList;
  id : TFhirIdentifier;
begin
  result := nil;
  // do we know that patient?
  if engine.FindResource('Patient', request.patient, false, key, nil,  nil, session.BuildCompartmentList) then
    result := engine.GetResourceByKey(key, needSecure) as TFhirPatient
  else
  begin
    // is a matching resource located amongst the pre-fetch?
    pat := nil;
    for res in request.preFetch.Values do
      if (res.fhirType = 'Patient') and (res.id = request.patient) then
        pat := res as TFhirPatient
      else if res is TFhirBundle then
        for be in TFhirBundle(res).entryList do
          if (be.resource <> nil) and (be.resource.fhirType = 'Patient') and (be.resource.id = request.patient) then
            pat := be.resource as TFhirPatient;
    if pat <> nil then
    begin
      matches := TMatchingResourceList.create;
      try
        for id in pat.identifierList do
        begin
          m := engine.ResolveSearchId('Patient', '', session.BuildCompartmentList, request.baseURL, 'identifier='+id.system+'|'+id.value);
          try
            matches.AddAll(m);
          finally
            m.Free;
          end;
        end;
        if matches.Count = 1 then
          result := engine.GetResourceByKey(matches[0].key, needSecure) as TFhirPatient;
      finally
        matches.Free;
      end;
    end;
  end;
end;

function TCDAHooksPatientViewService.buildPatientView(server: TFHIRServerContext; engine: TFHIROperationEngine; base : String; secure : boolean; patient: TFHIRPatient; session : TFHIRSession): TCDSHookResponse;
var
  m : TMatchingResourceList;
  i : integer;
  flag : TFhirFlag;
  needSecure : boolean;
  card : TCDSHookCard;
begin
  result := TCDSHookResponse.Create;
  try
    m := engine.ResolveSearchId('Flag', patient.id, session.buildCompartmentList, base, 'active=true');
    try
      for i := 0 to m.Count - 1 do
      begin
        flag := engine.GetResourceByKey(m[i].key, needSecure) as TFhirFlag;
        if (flag.status = FlagStatusActive) and (secure or not needSecure) then
        begin
          card := result.addCard;
          card.indicator := 'info';
          if flag.author <> nil then
          begin
            card.sourceLabel := flag.author.display;
            card.sourceURL := flag.author.reference;
          end;
          if card.sourceLabel = '' then
            card.sourceLabel := server.OwnerName;
          if card.sourceURL = '' then
            card.sourceURL := base;
          if flag.code.text <> '' then
            card.summary := flag.code.text
          else if flag.code.codingList.Count > 0 then
            card.summary := flag.code.codingList[0].display
        end;
      end;
    finally
      m.Free;
    end;
    result.Link;
  finally
    result.Free;
  end;
end;

end.
