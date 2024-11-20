Return-Path: <linux-kernel+bounces-415199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40E6E9D32D9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 05:03:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDD61283F87
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 04:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7257E43179;
	Wed, 20 Nov 2024 04:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="NS4U45fL";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="BGIDyjCm"
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A9717F7
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 04:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732075417; cv=fail; b=nF79cWWwCxsMqfmvyMGIJKz81V5MsXccssbIFZiZiP2PyiPZyVSZ9ITk//X/ruAt8t0XRE+HbJc+mF4KRjLJG3NL/dR6THYV9DnyYvSI8EoniWLS8iMRdw1crNucxmx4fv4P2n+t25t1bWsdF5kYZQUzU9UNI24xqkd06uvTuhg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732075417; c=relaxed/simple;
	bh=neTqu0QTUqapOHw1jzYqc78IMwdEqgsiZ6BMIhDaVzk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Fs1xxT2bE9BVqt1uLuR+WuHO1v0StYlLgW0oE3O88NrOXreg0WMam5bhixwWs9oMKsOUrkH95aZ6SOO4rV+gkc0ndv0ZKupLGoFtxWXPBu04fcOWKlIH5Fe0dHRBy5oWiJnnlN7MYkTNv/B9lMrzGganxqnLuLCLqZAU2OX3W+Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=NS4U45fL; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=BGIDyjCm; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1732075415; x=1763611415;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=neTqu0QTUqapOHw1jzYqc78IMwdEqgsiZ6BMIhDaVzk=;
  b=NS4U45fLbSvY9vQDoQU97j1ZPKSh1UaHSwV6Gp+na2IUA688bgAIyknR
   84F2lkYaxlGi7f1OIGVm1dzezqA+DO6FNeJ/CLWVrb2qEpJpMpE9hqrbz
   EM5bMIYL+aivhLWKhFj+znKj8akcpPpauaVchbKc9AOZrCLfU7VgHPxot
   o4dpYN6Ni6GH9qMCPLuk61aNslfEOcUT7APGM87STG6q1+Z2L4+W/pTxP
   8x7BLVZt0xWN3zgNBVGJzZW9YKjEQiH2L6XX1tctEObiXhoMs9PB7Wxvl
   KvdpRLehUkaOxDdqGwJGSScwfwHAMp7hDif4O5cuL/cQjn3lrEXObBGnB
   w==;
X-CSE-ConnectionGUID: Es1LNFqrQle6CCOVLL4MuQ==
X-CSE-MsgGUID: cnkDM7EVTXGUULDEZ3OHNQ==
X-IronPort-AV: E=Sophos;i="6.12,168,1728921600"; 
   d="scan'208";a="31818950"
Received: from mail-westcentralusazlp17013077.outbound.protection.outlook.com (HELO CY3PR05CU001.outbound.protection.outlook.com) ([40.93.6.77])
  by ob1.hgst.iphmx.com with ESMTP; 20 Nov 2024 12:03:33 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i8Log5WivEj5es5lf27Czru44QDwzhXyrGnWp3/UVfjCHv0v22Heznps7aexSF15ERboa3lX0fOpObNKo/jY9W8d/1WSDLe/K4wNW8ihU+O5x3+x7qP/+DLRSGNqFjgqXqquxtjd7d6OSP32mgzH4f5tfYBubtA1HTAO0QMcD82WchqEfU/UlSr460MnrykU/zaskg76l7I7/l16VHjhrrypcNecXoN5OofeAxT9IylFsr65IPvGNP7b6U1AgoNU630oAd0W0PIUepNwAbd3uXktB/GN5qZLeahDQN1cEedGo0wgNDl6kR1XAlrl0iVLsVJuTkEA8eC/4W/lCHr15A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=neTqu0QTUqapOHw1jzYqc78IMwdEqgsiZ6BMIhDaVzk=;
 b=Q8c0XPyJgqgOsdrRbwASvZycoqVyC4tdmIUrxARfT0hckT5HO4NhqEhWNn0USqo8ImNsuAk0O6q9gPElymnwi9qUVMSDs2+ItixDel7zKX4g4k7WrLteRzjTNLLXw8NQiawMZardvKLkJyB/iHDcpQTvjhe0T9T6h9HW290rfDd32llTHXofOgGgTfBLX+ds4gT7edmZ4vcKe5DSTa7nrnVYgBl/+LDQxaf+HHaXyTXwisuhmdWvq2J6WBBHE4HYt6leyISKzTheZbtRS3+ZNeRRq2wE+y9h//NRNAsdIrKHUmbSPz4BfQXxL7KqFA+S0faVFWvy/cEGDs1rwYwK8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=neTqu0QTUqapOHw1jzYqc78IMwdEqgsiZ6BMIhDaVzk=;
 b=BGIDyjCmXkbsLgu9+kWSbJwuyuDdfydPZHBG1tzbEQ6W0vZGknwMcEU8RAvoSgCs+ipu5xIQgMz5h/9LElQ4JG1LSk0UT8C4RVirJPiLve1yPAY19vBlpC1DmScJWCu5aqvUBTM8VLR5ujNrRXfmZ17DJrEiKu4om6llPl/Vmlk=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 BN8PR04MB6338.namprd04.prod.outlook.com (2603:10b6:408:7b::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8158.24; Wed, 20 Nov 2024 04:03:31 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a%4]) with mapi id 15.20.8182.014; Wed, 20 Nov 2024
 04:03:31 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC: "Daniel Walker (danielwa)" <danielwa@cisco.com>, Hans de Goede
	<hdegoede@redhat.com>, =?utf-8?B?SWxwbyBK77+9cnZpbmVu?=
	<ilpo.jarvinen@linux.intel.com>, Klara Modin <klarasmodin@gmail.com>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Danil Rybakov
	<danilrybakov249@gmail.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "xe-linux-external(mailer list)"
	<xe-linux-external@cisco.com>
Subject: Re: platform/x86: p2sb: Allow p2sb_bar() calls during PCI device
 probe
Thread-Topic: platform/x86: p2sb: Allow p2sb_bar() calls during PCI device
 probe
Thread-Index:
 AQHbNeKxizzLej0qw02u6pHMIY1jfLK1ZTYAgAACnYCAAAitAIAACmiAgAAOz4CAAq+GAIAAOFOAgAR9VwCAABNdAIAADFAAgAACZoCAAASkAIAADOkAgAAWSQCAAAGAAIAAFMqAgACYawCAAHn/gIABNQcA
Date: Wed, 20 Nov 2024 04:03:31 +0000
Message-ID: <obttk4pp3uw53blfvaolwakzhqij2xyqbu67b3li7dseni6kb4@ipvay77dd753>
References: <Zzs1rw1YcoEEeW7+@goliath> <ZztABO3TyJBekZRs@smile.fi.intel.com>
 <ZztCB5hN2NBnPgiR@goliath> <ZztF7FKaBwZKs5dk@smile.fi.intel.com>
 <ZztQwLpoZDZzbi6O@goliath> <ZztjcntEj5Eo0Rw9@smile.fi.intel.com>
 <df1fa47f-7efb-4b0c-8ef6-100b12ab1523@redhat.com> <Zzt2JNchK9A0pSlZ@goliath>
 <p3lt3psoxenwlvxu6yjpjk4yskrplagj54vk4vxkg6biudghus@go6hpoakvfwh>
 <ZzxcV7F32K1_Oo8X@smile.fi.intel.com>
In-Reply-To: <ZzxcV7F32K1_Oo8X@smile.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|BN8PR04MB6338:EE_
x-ms-office365-filtering-correlation-id: 6d4ce97a-f938-4c0c-cade-08dd09184c00
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?ajJ0cnJXK1dSWjMrY1EwUmpEL255b0tOTm5WeFRVcnozS1ppeUd6YWg2MXFK?=
 =?utf-8?B?UTlyWGQxUEt4cGJrR29Hc2hBNTRDanNHWU9zSUFYaWdSTGJpakUxZ3d0TlFM?=
 =?utf-8?B?dWJUUE9GUWI4VEM5U3Uya1lRWDZWSUJSN1EwOVNCb2FON0JwRHhiei9teTB6?=
 =?utf-8?B?ZCtlSGZoeVJkSDdvWS9aNGo3WnloNVBESUtRUkdYMTBld09RWVp2NTZKdjMv?=
 =?utf-8?B?dGJwQndmZFF1Ky9PaVR3ck43OE1kcTVwY2ExV1RrNDhKVkdpQlVuYUYrYng0?=
 =?utf-8?B?QjVER2hjQytGbXhCUFF5Z0R5YUJuTkMvWDQ1OUdzV1RqRWx4ZlFndTRMODVG?=
 =?utf-8?B?TzhFakNqcTYvcTRpVGJFa1BOZWNMV2NhWXVpRENjRnVNci90Y09LWit3YkJK?=
 =?utf-8?B?MzZvM0Zac0Z0bDlYKzR1SDRFKzQ5bnQwOFlUT0JzWVRZWmMxenRVdU1ybGcw?=
 =?utf-8?B?TUxJWjJlTmV0WlpDeGw1anpkR2lwd3E0MWRuVnFIdHNUQ1FVdkVXcWkxcVV4?=
 =?utf-8?B?bm9SMEJoamhsVEtVT3hMRnFneTBZZWtPQkFJcVNNSWY3VlVwNzlQVXM1czNV?=
 =?utf-8?B?ZlhicDZRM3FqcVZWWGEyVEZ3QlJ4WFFtZStEWWcwa2g2UWJPQ25FZVpZa3Jm?=
 =?utf-8?B?eU5xNUFTMHVPRDFCZ3pYZHJNU1JZWUEwOStNSzRCbmxFQ3pKMHJuMXZiQkhZ?=
 =?utf-8?B?TnZudUdhWCt3a010M3dwdWdWb2F2bFBGMFQrdEFGTnJsU0hGRUEyZ09CY1V3?=
 =?utf-8?B?STNOK3A2MGtKZkY1Ylhwam9UQjJxMFBKWHl3TGtKdjh3VG5NbVdnVnRjNFV3?=
 =?utf-8?B?dFhTSjFpRG9BWWg2R2szRGdVdnU2dzRsaS9jUS9Eck51UEhaT0I1a2luN2lC?=
 =?utf-8?B?V2R0eUtIRERRWGRicmZpN3VURlRST0twcWJpMk1tY2orM2xWSHJvVnR2SzNs?=
 =?utf-8?B?T0hNZ21aZUMvTjBGM3dpaktJZ2pCT21Vd1FzeW0yOGFrVTYrelgxa3NucUVn?=
 =?utf-8?B?d1pwc283ZmErMnRYNnlwQ3RweEhzU2MzeXRYaW1MaVV5SW45bVJIZTIxb2Jm?=
 =?utf-8?B?eWtvVmhLaUNCM28wTFNhVFVteERZeXhIdzE3YTQ0cEVZUUU1NXh2ZklmUDlB?=
 =?utf-8?B?OHZXNkFKeG1DRndWT3lreCtiZ0lVeDFZOWlwRGkzMGgrcEVDaUFRWWhOYXI3?=
 =?utf-8?B?WGgrVDB0Tm1aQmdDUENCZ3ljM3ZBYW9UL0hLUjZRVUM2MWNxYXpFdTdhbzRX?=
 =?utf-8?B?VGVNdStXWmVLdzZVRm04TkMvSlY5ZE5CWEEzTDl5cnFPZVB2R21lTmRkL3Rz?=
 =?utf-8?B?RHdvZ1Zyd01TSlJ4VnlXYWhQb2RRdU9TanlvVFhjTkVRREtzY2R5aXBUdjhh?=
 =?utf-8?B?K0RuRkc2OEZ1RmlUUVlkL1VQWFBXSmJmbElBUVVWUWlNYzZsVU9LQVNscXBl?=
 =?utf-8?B?RFZlaDk4RFkrOThnaXZlNTFJZWtCRTNwazF0aDJKQ3l1dzVoeHNvNTlIN3ky?=
 =?utf-8?B?ZmhIYjlrdEp5MHhVUHM5UDQrK0dZc3BPaGl3YXlwdDdzUVdDa2MvbGdXMmxz?=
 =?utf-8?B?VmVQbDdrdUlqdWprVFBaVklzYVFrOHRmRWZBODQ2YVM4Rk1Fdkx1clgwWTh2?=
 =?utf-8?B?bzVtdlo2R0pyeUtqcUxJdlJkaHBka2NpK2hxTEczTzh1bGtUVFEyRlBhUytu?=
 =?utf-8?B?cExIMUhBM3d6TWZBWWNCcWRWVlFYeFN0OXFZYWZUTlVtRC81NjlFNVdZd1k4?=
 =?utf-8?B?VTMyQ1RPL1gyRUtCWE01Tm1rc0d1ZTBsR2JIdVRaSFdNSVJoNVVtbUM4SDJK?=
 =?utf-8?Q?hoHyN1XH3RbhFMsROGMxB/5wqvIsLsegDtQ84=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UXlqSnhBbjA4bEtzMmhNRUJRcFRET24xcHR6Qm53dFhlUjgrSTE0czdGU1Nk?=
 =?utf-8?B?RlhkV0lCaXorMXVjUDM5RmdRbVBBelVQVTJlMTFoOEdQNWI5amxYeXdHZHhT?=
 =?utf-8?B?SDZmcU5BSHIwdWhjU1NvS0NSeXI5WHVvUVdjSUFpZE8wZUhQRWUzRUY0N0lY?=
 =?utf-8?B?MWNRdGVBNWtzd29NWjB5YXZGeWNPQzhpc0R2NnFLUnprQ0w3V3VWVUUrR3Q1?=
 =?utf-8?B?U0x3QURscWNlc2VaV2lZRUpIajRVaXArWDZjRy9qVnBvMXFIdW5SUTBOTUVG?=
 =?utf-8?B?NXcrOU1iK0tRZXBLNDdHSU4yTUs0aTE1dnRPZlhpV1NIZDNFTGZEVVQ2ODRy?=
 =?utf-8?B?eVYxdC9xR0VYa2QwaUZjM1pWd2ZWd1RmL2pqWUZGUWF2bWRONzBaN1BxQW9D?=
 =?utf-8?B?TGxlOHdidzVoZ1N1UWRRc3JKT1pqQjJXWG93VjNpUGhCdTRhTXpwWWF1d05O?=
 =?utf-8?B?KzNwUmxZQVJ3N1FhWXk3WnpTZ2UvQVdwZ3NLLzlSMUhMbnhGNFJRbnFRR2Fm?=
 =?utf-8?B?YjJidTNIWENybXdCU2N3eWE5WUVsbEpOUGZNVEhrdC8vWG5VUko4Q1I3dlpi?=
 =?utf-8?B?Q0p0L0p2ZUYreGlBSmN4MVF5VmR3czU0emoxc2lWNXVKb3VlaDJFcHQvbktP?=
 =?utf-8?B?cWFVdVlRMEVIdkdubVlCZ0hZUWt1VUdTQzU3YjhZOTRxTVdhU1RmTm5pR0s4?=
 =?utf-8?B?MXoyUG94WFd2Vzh2b1VLRWIxc2R2UUNWTVRoT0xKTlFuczhGNnNYdFJMY0hr?=
 =?utf-8?B?SkNvN3RFdFBJRkhFL0t0a3pTU3FLMytjb2VuLy9URFd3R3FUOCtNMWJ1SUtZ?=
 =?utf-8?B?UkdUbFN0TzU3OVBQVUEzMUxLdUF5RUs4bFRRNTlpcC9LbksvZnJ3Q25Uak1C?=
 =?utf-8?B?TlZIUFdSL045N09FOWIxSWtTbDJRTTBoczFkeEpXYUVpV0VSMU1DeU1Uakkz?=
 =?utf-8?B?d2tJTlZEcWtqdTFmT3MyeTNOZlIxQnRjV1ZCNis2TWhkTUR1SGV3czB1NGx1?=
 =?utf-8?B?VjdDbzRrYmt4cG1nY2tsUlJZWkxGN0lSWUpETW1EczN2c08rRm9zY3l0Z29z?=
 =?utf-8?B?VE81MjdyQ3RNV1BpN0hXM05rd3lyd1lUcmEwaVNIdGJSdlp3RlFnZWlZQ1BB?=
 =?utf-8?B?NmdsT3pRRndEWEJ5akJhL293anlyZFR4SHNXcW1wRFpJclBnY2RhMGlyd3pw?=
 =?utf-8?B?NFZVOHVLS2dqeEx1eDI3UTFGZmtTcnpVUGp4WmowM1pDWlFleGtwekt6WWxx?=
 =?utf-8?B?WHFWdGtLUStpOVJyNlBLeXJwVlN0Um5XK3FpeWFwWlorVngrQXRKd0NaeTcr?=
 =?utf-8?B?Qm1VMUZCR01rZW5yb2c0NVBhN1pETE82bmJxdjZLNEFmSGNVcFNiWG8wdGRN?=
 =?utf-8?B?cGJBa1JsSkZOZTE3RkpIdFkvT1F5Qkt4WnVxdzhqalM2akwrNjZqUFB5eUxR?=
 =?utf-8?B?MTN5aVFrby9UMWNId21NSzVuVTc4dm1PM3VkZWdHOWg2cXNnWVpPWTdJbEtH?=
 =?utf-8?B?RWVrMEtuaFFMZytLUjBVWHNXc0NoTnhvTDFHWm01bmtyLzgyaXJ0TVpPNUYx?=
 =?utf-8?B?ZkcxWDhLRnIzZ3lySlZzNEdmZXM4eHNVNXlyWTZ3M040eHZwUFN6cjE2UFA2?=
 =?utf-8?B?amhLZmR6N2ZaTWRXcDRlQ0dvT0VocjdubVFXd2xjNFZWSVo3bnZtU3hNMDFJ?=
 =?utf-8?B?RUhzRFpTNm5jR1k0Z2oyTWduSTY4T0lHYlh5SWJ5aTd2SXlXck1TU0tSTmkz?=
 =?utf-8?B?WGdKZWpRVi9JT2pncTRmV1NPMGR1MENTQmNURnAxaS9mMTZsZVd5Tjc3c05w?=
 =?utf-8?B?MExjMUtHT29Nd1p2Q2NRR2U4bU9Hc1RaNStRSG1ZdEVkcnZGcFVkN05mM3JL?=
 =?utf-8?B?QzN6ZGJOUy9LKzVZMjQyclV4LzBMeksrQ1N1OTJ2d1ZleGxqbSt0K090Y0xv?=
 =?utf-8?B?cVZqUFVpM2Q4MFZEaFQyQWJGeW1TNVM4aE15a0pVVllic1hYMTI0VytrVjIz?=
 =?utf-8?B?dGIvZUhwMWhiQWFVZEVXVjd1TjVLU2VOSkJhNzhTRS9LRVZ1WXF6UjgxbjJr?=
 =?utf-8?B?TWRNMmovRGZ4Z3RqT2J0TkNZdkNBQmJsa3dKQjNxeGU0UjlyR290bW1KbGkv?=
 =?utf-8?B?RVVnUllmazhUSFY5Sk9MQzNhNWR4a3hINlg2ZUZwbjlwUnl1S2tHQlZ5NjZT?=
 =?utf-8?Q?QdE4cU+vz+TERVIf2+soi1o=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <73D92840DE305A438B9332393E2B95BC@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	O7cziCr6ORz9/Y5Z42066dDJwE4BQBlb5HogkjmV+4SyoMa3ivGTHGmVJhlx1NBmvzNRuT1II3P/lOnzldn0ky70xe5hnZXyKTl6Gy6u5PlkDz1LHmvdbgNZF1NOIQRKXyF7BjGdYQb2Joobj2XT8u2S93icFF22A/OKj6AZrzSCKABH+TaLRef2GwXvpyhAuGWfNzVTkKuTVnoizaGhqsJm4+sJ2SzefkThH8AGXVwSDZ2riGbCp8vgQmNRMsTF81m5ZXpth70OA5+CyTflpxKI4ayLphfo5J1S1dGn8ecilTZAqeS35ATTlWEs8v5X045860t3ePW0tw0ORMC7ddLmCR2lbqMiapxvoOX4oI1R8V7zxPHAzv64VulRajdSBYsIbYOiwnPrzUYAygnkwMx6PBezUMuXtpigEGEpxX2mbG1dG+0dNVYI8zwPqY7IQC4NqD5UzaybgQqjnqbuZ9bdLg3UnHfTc5IZfsYV0caVSprbGMu14NDETzl2i/H8vx4ZAgFyteY4YIcWNbFhHfuSbMlccRp56d6Utw/LU72DANhfGlhqovOZ/xZzTU2D2hrif8lyZI/fNeGootHrpcMlZskpu+DGVkEPBYG2vaJYs/ubbQbxQWbWFGy0H18D
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d4ce97a-f938-4c0c-cade-08dd09184c00
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2024 04:03:31.5161
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f4AhANVDK4eKhP0Co5VCN6mJgcICnTPG1vDU/Vu1X7vG6Ne1KsxdDp6WexBTGZPDQklI2zRLjQfV9tzDU8/yrn75msZyKLRpIj7Cv5+N7ns=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR04MB6338

T24gTm92IDE5LCAyMDI0IC8gMTE6MzcsIEFuZHkgU2hldmNoZW5rbyB3cm90ZToNCj4gT24gVHVl
LCBOb3YgMTksIDIwMjQgYXQgMDI6MjA6NDhBTSArMDAwMCwgU2hpbmljaGlybyBLYXdhc2FraSB3
cm90ZToNCj4gPiBPbiBOb3YgMTgsIDIwMjQgLyAxNzoxNSwgRGFuaWVsIFdhbGtlciAoZGFuaWVs
d2EpIHdyb3RlOg0KPiA+ID4gT24gTW9uLCBOb3YgMTgsIDIwMjQgYXQgMDU6MDA6NTJQTSArMDEw
MCwgSGFucyBkZSBHb2VkZSB3cm90ZToNCj4gDQo+IFsuLi5dDQo+IA0KPiA+ID4gPiA+IEhhbnMs
IHRoZXJlIHdpbGwgYmUgbm8gbmVlZCB0byBmaXggYW55dGhpbmcgaWYgdGhleSBpbXBsZW1lbnQg
Y29ycmVjdCBhY2Nlc3MNCj4gPiA+ID4gPiB0byB0aGUgR1BJTywgaS5lLiB2aWEgZHJpdmVyIGFu
ZCBib2FyZCBjb2RlIHdpdGggR1BJTyBsb29rdXAgdGFibGVzLg0KPiA+ID4gPiANCj4gPiA+ID4g
QWdyZWVkLCBzdGlsbCBJJ20gbm90IHN1cmUgaG93IEkgZmVlbCBhYm91dCB1cyBoaWRpbmcgdGhl
IHByZXZpb3VzbHkgdW5oaWRkZW4gUDJTQi4NCj4gPiA+ID4gDQo+ID4gPiA+IE9UT0ggSSBndWVz
cyBpdCBtYXkgaGF2ZSBvbmx5IGJlZW4gdW5oaWRkZW4gaW4gdGhlIEJJT1MgdG8gbWFrZSB0aGUg
aGFjayB0aGV5DQo+ID4gPiA+IGFyZSB1c2luZyBwb3NzaWJsZSBpbiB0aGUgZmlyc3QgcGxhY2Uu
DQo+ID4gPiANCj4gPiA+IEZyb20gYSBmbGV4aWJpbGl0eSBQT1YgSSB3b3VsZCBzdWdnZXN0IGlm
IHlvdSBjYW4gbm90IGhpZGUgaXQgaWYgaXQncyBub3QgYWxyZWFkeQ0KPiA+ID4gaGlkZGVuIGJ5
IHRoZSBCSU9TIHRoYXQgd291bGQgYmUgYmV0dGVyIHNpbmNlIHNvbWUgY29tcGFueSBtYXkgaGF2
ZSBhIGdvb2QNCj4gPiA+IHJlYXNvbiB0byBtYWtlIGEgY3VzdG9tIGRyaXZlciBvciB0byBleHBv
cnQgdGhlIHBjaSBkZXZpY2UgdG8gdXNlcnNwYWNlIHRocnUNCj4gPiA+IFVJTy4gVGhlIGN1cnJl
bnQgc2l0dWF0aW9uIGlzIHlvdSBjYW4ndCBtYWtlIGEgY3VzdG9tIGRyaXZlciBpZiBwMnNiIGlz
IGVuYWJsZQ0KPiA+ID4gd2l0aCB0aGlzIGFkZGl0aW9uYWwgcGF0Y2ggZXZlbiBpZiB5b3UgdW5o
aWRlIHRoZSBkZXZpY2UgaW5zaWRlIHRoZSBCSU9TLg0KPiA+ID4gDQo+ID4gPiBJbiBvdXIgY2Fz
ZSBpdCBzZWVtcyBsaWtlIHdlIGNvdWxkIHVzZSB0aGUgYWxyZWFkeSBleGlzdGluZyBzb2x1dGlv
biB3aXRoDQo+ID4gPiBwaW5jdHJsLCBidXQgb3RoZXJzIG1heSBub3QgYmUgYWJsZSB0byBkbyB0
aGF0IG9yIG1heSBub3Qgd2FudCB0byBmb3IgZGlmZmVyZW50DQo+ID4gPiByZWFzb25zLg0KPiA+
IA0KPiA+IEkgZG9uJ3QgaGF2ZSBzdHJvbmcgb3BpbmlvbiBhYm91dCB0aGUgY2hvaWNlLCBidXQg
SSB3b25kZXIgaG93IHRoZSBwMnNiIGNvZGUNCj4gPiB3aWxsIGJlIGlmIHdlIGtlZXAgdGhlIHVu
aGlkZGVuIFAyU0IuIEkgY3JlYXRlZCBhIHRyaWFsIHBhdGNoIGJlbG93LiBJZiB0aGUNCj4gPiBk
ZXZpY2UgaXMgbm90IGhpZGRlbiwgaXQgZG9lcyBub3QgY2FsbCBwY2lfc2Nhbl9zaW5nbGVfZGV2
aWNlKCkgYW5kDQo+ID4gcGNpX3N0b3BfYW5kX3JlbW92ZV9idXNfZGV2aWNlKCkuIEluc3RlYWQs
IGl0IGNhbGxzIHBjaV9nZXRfc2xvdCgpIGFuZA0KPiA+IHBjaV9kZXZfcHV0KCkuIEkgZG9uJ3Qg
aGF2ZSB0aGUgZW52aXJvbm1lbnQgd2hpY2ggdW5oaWRlcyBQMlNCLiBEYW5pZWwsIGlmIHlvdQ0K
PiA+IGhhdmUgdGltZSB0byBhZmZvcmQsIHBsZWFzZSB0cnkgaXQgb3V0Lg0KPiANCj4gLi4uDQo+
IA0KPiA+IC0JcmV0ID0gcDJzYl9zY2FuX2FuZF9jYWNoZShidXMsIGRldmZuX3Ayc2IpOw0KPiA+
ICsJcmV0ID0gcDJzYl9zY2FuX2FuZF9jYWNoZShidXMsIGRldmZuX3Ayc2IsIGhpZGRlbik7DQo+
IA0KPiANCj4gSWYgeW91IHN0aWxsIHdhbnQgdG8gaW1wbGVtZW50IHRoaXMsIHJhdGhlciBtYWtl
IHRoZSB0d28gZGlmZmVyZW50IGNhbGxzIGhlcmUNCj4gDQo+IAlpZiAoaGlkZGVuKQ0KPiAJCXJl
dCA9IHAyc2Jfc2Nhbl9hbmRfY2FjaGUoYnVzLCBkZXZmbl9wMnNiKTsNCj4gCWVsc2UNCj4gCQly
ZXQgPSBwMnNiX3JlYWRfYW5kX2NhY2hlKC4uLik7DQo+IA0KPiBvdGhlcndpc2UgdGhlIGNvZGUg
bG9va3MgbXVjaCB1Z2xpZXIuLi4gOi0oDQoNClBlciB0aGUgY29tbWVudCBieSBIYW5zLCBJIHdp
bGwgY3JlYXRlIGFuZCBwb3N0IHRoZSBmb3JtYWwgdmVyc2lvbiBvZiB0aGUgcGF0Y2guDQpJIHdp
bGwgdHJ5IHRvIHJlZmxlY3QgeW91ciBjb21tZW50IGFib3ZlLiBwMnNiX3NjYW5fYW5kX2NhY2hl
KCkgYW5kDQpwMnNiX3JlYWRfYW5kX2NhY2hlKCkgd2lsbCBkbyBhbG1vc3Qgc2FtZSB0aGluZywg
dGhlbiB3aWxsIG5lZWQgc29tZSB0d2VhayB0bw0KYXZvaWQgY29kZSBkdXBsaWNhdGlvbi4gSSB3
aWxsIGNvb2sgc29tZXRoaW5nIGZvciByZXZpZXcu

