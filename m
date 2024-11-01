Return-Path: <linux-kernel+bounces-391571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67D459B88D2
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 02:45:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E92F01F217BB
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 01:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CAAD73451;
	Fri,  1 Nov 2024 01:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="av0t5IbS";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="KxXLEHE3"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC3984E1C;
	Fri,  1 Nov 2024 01:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730425477; cv=fail; b=n2/w41GJku3u1X0dtoOR0YEMX74XreNVTxrR4tY1WfaYvuI1EkUcpQFT6w7xN7e6sND4WJnajdpkM4Jw/HMdkrE7T2HCzCmsqAmLmheO1khUUhLx1Wnyx9osIUHokU6s46D4mybsrUnc+ls1WawetkhIKKil2kgkoRSp5JPlxP8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730425477; c=relaxed/simple;
	bh=Va54Dsh8VARfErqOPBwjG1yhdPP9daeMhRbqJm5nAc8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DgSX0sWZZOCwCnz/jGjNUUWYDqSDLt+TfIeZ+kETtbC75eavmsfNZ0krTBs8CApd8BfDpeMETFVx7APyiPNTWUVbnZ3YBmHZjS0kVl4s0wN/K9IYC18M6phv347q9h+MwKOcItBJ57c+uiBBEtn19FISB/FWGYQBcPTbAOm2+6w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=av0t5IbS; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=KxXLEHE3; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: d07f2a5097f211efbd192953cf12861f-20241101
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=Va54Dsh8VARfErqOPBwjG1yhdPP9daeMhRbqJm5nAc8=;
	b=av0t5IbSVYI40qY2ypvLmnPCcjBjJj7n/PSsk7WEr+76kuo63wnIckE8kINpd7L1OH+qQx1PTF1Zm5b7pip0MtjT7LXJe/iTyCIQBIZ8Fqfx0gGD7eeKZ7jtEgKJOAPD2sZ/w9blg4hKiB0SP58wNNaUp6spbSAinkSL3R02E5Y=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.42,REQID:33548dc4-1b82-4aea-aa87-829da35cd798,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:b0fcdc3,CLOUDID:8dfc5de7-cb6b-4a59-bfa3-98f245b4912e,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: d07f2a5097f211efbd192953cf12861f-20241101
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw02.mediatek.com
	(envelope-from <cheng-jui.wang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 336965121; Fri, 01 Nov 2024 09:44:20 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 1 Nov 2024 09:44:19 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 1 Nov 2024 09:44:19 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lSm+MruQtzdKkJK3WjOKJ8PAup/7pLL191el0nZ7Eu9TG6eWBUhq3acsiVJyKM200OrfekzKBpd1os3naoG2P/AaqnwNoqVkxeaVJL5Zwxc3+NvFgPOkELjggVzupH6pmcOWbl7FSYSArCBmsSn3+lh3qpRPiP3UzlgVt+ETMgi0zUCEWYRFxO0FXVwWOA7ngc+h7L75+R/72QkFTx/ojP+6o+IsArKhxfmmnmTFiy5WmougCvRFjw1q66RKayAyKWl1656C6SbrgfrdhphYC6sX8MDZaizdp3WJ4jrzrzZqWKvCI1TwPB5tM2qVgPUCcMBWDxaMOsyhguDZI6N6lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Va54Dsh8VARfErqOPBwjG1yhdPP9daeMhRbqJm5nAc8=;
 b=EoIBPtHV4LAEhQiAFWTEdi9wheP9b43f5EFiQEkyCoCLrKkLTsNocZva2KNahp9T+/HLySww4Wok9N2ziaYjcgWbqKAjthx0PyDKv85aeyOZfpqDdvh6SExHnPbrkODbs53xLp14qG7xWedI8bkdwCe1oaCG9fVuev79aX5rxrdcu0rUEyzki9zmflzhkbIumSb3mZf5hfTeU6LAvF3kcrvWB4VVirholJUdfcOmcqcaOjgqnFmIoR4Kc11icDYyeLuZcIcfOX/3tf9+EVlC5hxtB+igTRaPS04R23fE3cBp3sHoyxfXxQLwURSnsqKuUkuAOh4zRvndFJ1NyUnApQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Va54Dsh8VARfErqOPBwjG1yhdPP9daeMhRbqJm5nAc8=;
 b=KxXLEHE3nDwWS2JJ9IWmXJoQTmJtTGaXeiFfQyyOVDZS6bPLZr5wvOdxfSEsa5a37WH8+HPpzrhAhXcT7QL7bD82TFppHepRLJcaNGUDdX+UlmzpRiVwsL07ZCwPZhzQjAi6LgnN4y58c2qTCXnR/TkXgIbJEHPAFgk46IjxGfo=
Received: from SG2PR03MB6415.apcprd03.prod.outlook.com (2603:1096:4:17e::8) by
 KL1PR03MB7526.apcprd03.prod.outlook.com (2603:1096:820:e6::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.32; Fri, 1 Nov 2024 01:44:16 +0000
Received: from SG2PR03MB6415.apcprd03.prod.outlook.com
 ([fe80::c608:6d96:245d:bb40]) by SG2PR03MB6415.apcprd03.prod.outlook.com
 ([fe80::c608:6d96:245d:bb40%5]) with mapi id 15.20.8114.020; Fri, 1 Nov 2024
 01:44:15 +0000
From: =?utf-8?B?Q2hlbmctSnVpIFdhbmcgKOeOi+ato+edvyk=?=
	<Cheng-Jui.Wang@mediatek.com>
To: "dianders@chromium.org" <dianders@chromium.org>, "paulmck@kernel.org"
	<paulmck@kernel.org>
CC: "sumit.garg@linaro.org" <sumit.garg@linaro.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"rostedt@goodmis.org" <rostedt@goodmis.org>, "frederic@kernel.org"
	<frederic@kernel.org>, wsd_upstream <wsd_upstream@mediatek.com>,
	=?utf-8?B?Qm9idWxlIENoYW5nICjlvLXlvJjnvqkp?= <bobule.chang@mediatek.com>,
	"mark.rutland@arm.com" <mark.rutland@arm.com>, "kernel-team@meta.com"
	<kernel-team@meta.com>, "joel@joelfernandes.org" <joel@joelfernandes.org>,
	"rcu@vger.kernel.org" <rcu@vger.kernel.org>
Subject: Re: [PATCH v3 rcu 3/3] rcu: Finer-grained grace-period-end checks in
 rcu_dump_cpu_stacks()
Thread-Topic: [PATCH v3 rcu 3/3] rcu: Finer-grained grace-period-end checks in
 rcu_dump_cpu_stacks()
Thread-Index: AQHbKZuQD0a1bmt83kGqJ5+0CTWhuLKc/yAAgADtCYCAAWdPIoAAaUaAgAA2VwCAAA9JgIABYhE9gABHdYA=
Date: Fri, 1 Nov 2024 01:44:15 +0000
Message-ID: <612522fc41698c029e35e13d170339d21703b334.camel@mediatek.com>
References: <92193018-8624-495e-a685-320119f78db1@paulmck-laptop>
	 <20241016161931.478592-3-paulmck@kernel.org>
	 <c3218fbe-7bb1-4fd6-8b00-beee244ffeae@paulmck-laptop>
	 <b2b0bceacbd080e13b3aa7ad05569a787df4646d.camel@mediatek.com>
	 <adb044e2-8f62-4367-9a22-30515f5647b1@paulmck-laptop>
	 <d0adc7d14da0f21909eef68acf19fc5706a4b1af.camel@mediatek.com>
	 <9e90d04e-081b-4730-890b-295ed52747de@paulmck-laptop>
	 <CAD=FV=WBcOCGbD0haRYLGgAFpDhfoqMW8mvj9DEA0CSPHG3Owg@mail.gmail.com>
	 <63859e70-2ea7-4a67-857c-fa226566f25a@paulmck-laptop>
	 <CAD=FV=WsM=om=xobfWkC8nLQNK89xdyNNX=L1=DjD79ZPXYxRg@mail.gmail.com>
	 <1617541e-4853-4567-b9c0-febf1cfa26a8@paulmck-laptop>
	 <CAD=FV=XHD9FhUPLHWRFSRzuHqoBFKT3_cDwMr0ApOBBOjPNnAg@mail.gmail.com>
In-Reply-To: <CAD=FV=XHD9FhUPLHWRFSRzuHqoBFKT3_cDwMr0ApOBBOjPNnAg@mail.gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SG2PR03MB6415:EE_|KL1PR03MB7526:EE_
x-ms-office365-filtering-correlation-id: 63a43b97-d605-44a3-87ec-08dcfa16b195
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?Z2pnNktaUkNFWHBjQmtqRGIxWWQ4OGF6Yy9aK1FQZmN1cTBYTWRDSEFBZGJE?=
 =?utf-8?B?N2dZWHlKKzJ2UThGdk14Y0djRS84TG9vUU5GNWdTbFM4Qm1DOUdsUW9YUnUz?=
 =?utf-8?B?NmdBU0o0TS8weWhwWHB2YTRkc1d4SVh1SEtzcTlvNkczSjVtUXl5L3NQRm1r?=
 =?utf-8?B?TDNSYnVUTWtqazJmS2dvdm1ZRVVqSGNXQUtjRjFTYVJiVkNxcE9JeDduc1l6?=
 =?utf-8?B?ZVRmMFFybnRpZ1ZHK2o4Z0I2UUl5OEQzbWxhR0s0TE1EaFRCa0ZyUWlYeGUx?=
 =?utf-8?B?SERQd2tJNm1rZGowQm44VkVtLzAyblkyK1VuUm5jV0JGWTdjWG5BOFVRWDRG?=
 =?utf-8?B?Z0pTeHNVZ05mWVJwRkhUclVSMEl1elA5Q0Z6ZlN6UllBeXNXS0NRV3g0KzVV?=
 =?utf-8?B?K1BjRGlVM1VvV2RlWjRZV1VkVmZTSXFhdHF4RnpwaUExYllQUUtHbjBLNTBE?=
 =?utf-8?B?aVpLdjk2RlowVUJPcko0aGJWSXA5ZmlIamowRDlaQ0FUVXdXaXVtZ2lkaE9n?=
 =?utf-8?B?cXlBSlY2blUrZ0xtSWFYWSs1NCtJT2RSN3M0VDRJNG01cG04ZW16SWRDV3p5?=
 =?utf-8?B?SWhMRWswVGU0ZUhIbUl2ZEN6QVpRRDNVeFBMd1l1ZEFtVmYyS3I2aDgzQjdz?=
 =?utf-8?B?elpKd2g1cEVuWUZlRW5JVk52R1N4Y3BQQm5jTnJZdFdSOUhQYjNrUUFZbHZv?=
 =?utf-8?B?QnhMNzh1LzVORlYvTmV1ZjJRSGhWdmxMZ21IVmg3YWJLWE5pVHpTeU9ia2N5?=
 =?utf-8?B?cUYxM3pRZ0gyaDJORkkvZVFubFF4TEdnUkxuZDh1MlVwL1o4OFpLUHk5L3h4?=
 =?utf-8?B?bXN2TFRpNzUydmtNZVQxNGFyTDhwL3Y3aXVhRlI4eEM5ZmkwdUZWYTNFM3RE?=
 =?utf-8?B?V0QxYm1tbXRPNGlId0czTi9iQVRuM2g0ZGJYUTBXRk41N1FtemRCMEgyMFNw?=
 =?utf-8?B?NUZlTU45QlZXUW96cmlpNGVRcHFsSTd1UVZHZzdEWERCVHR1KzdjdDJFbTZn?=
 =?utf-8?B?cE9JSWYxeGtVdWhOSFdEd1d4KzNsZkFJSmExa3NxaU05bHB6Ny9nem0wYkJS?=
 =?utf-8?B?VHMrTEw0Wk9jKzA4QmtoV0FMNS9KNG1tb1FaUytJaEtGTE9HamoxeHZ5Z0c3?=
 =?utf-8?B?WExCMUFwNGl3UXFHRVZUWEc3a1dQL056VllGeCsraWZUYWMzd0owVkNIQ3lV?=
 =?utf-8?B?ZnZNOEdBTEkzL2Z3ak9DcVVXRVBLZm1DUnVYUUZyV2cxMkNKTTF6clNVT083?=
 =?utf-8?B?NHBOb2VBbHNoa1ErN1I5TnBKZU5TOXcrUy9XcXBZRVRIZll5MzFGcVYzc29L?=
 =?utf-8?B?emJBaWlHZjRTSkwyUFJBQUpqMzluSnI2UjJNZkRLY0Njck4zK0ZhaVBVdFhh?=
 =?utf-8?B?K0ZDd2dIZS92RmI2L3NWNDFIeEhuT2lPdEFtTDhOMHN5REFlR1k3QzYzRFZW?=
 =?utf-8?B?RnhNbVhtSUFobGRWTEk1d0gzWms0NTNSaGZzSFIyU0hpaTdDVFMrVXhDWVRN?=
 =?utf-8?B?dHcraHZCZFFBSmRmNHVaTU5qTDM3MnVaNTRkY2JnUEMxOTJzNGlnVGNlUGho?=
 =?utf-8?B?NTJOcytOMVlQUkNQUkRNN1p2Y3ZDSWxpTXNjSDdzdHNrMGZNRlhOOUxyUFNQ?=
 =?utf-8?B?SXRVck90TDhQdHptWUJIUmhyTzJSSUFVb2ZpZ2NZZ0JsQ1NKNHczaDNJZkFQ?=
 =?utf-8?B?U0dwMkxZZGdLbG40QVR4R1F2akVvYjhwcm1nM0ZqWG5sT1kzU1dUU2toa0tI?=
 =?utf-8?B?U3QvcHBoajdvL24ycjNiK2N6cDRqb0h5ekFOekI1VG5CTG9DaXNNOGZDS2NZ?=
 =?utf-8?Q?pjQRKo12ccEmTZfEMcvOKUfsDAk2HeL8qmAJc=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR03MB6415.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QmM4YjJRTG9wV1Q5VXB0SWhrcnZYa2w3YUhrTzcrRGJ6V0V3M2Z0ZXdDdUpx?=
 =?utf-8?B?WlNuTHE5VWJKTHdxTFpOc0FDZ1dZSWMzczdHbktONVlzSEE4OThMSFB0a0pI?=
 =?utf-8?B?V2NPY2VPLzJ5WXg2N1JKa3B6NjR1dzlZVDdXKzdoT0VyQjhYK1dlaVl1WXN1?=
 =?utf-8?B?STZKYlZCNExpMnNtOUg3b3V1VmZXR0FlR1QyMTY1SkxRYTRXSXlTdUYzMG02?=
 =?utf-8?B?TFNKTktDSXJlcFdlTUNrYllUZTZOcm9OS3ZsQ0F0eE00bWlmLzM3cjNMRmk3?=
 =?utf-8?B?MzBnb2daNUFGeDNpVGFMUG5pSGx4T1hIeERGR2VUcUttakZMd3l3OVpuQXN5?=
 =?utf-8?B?SGpPM0pnUS9vYUFrTUdWLzQ4V1ZLaGtldi9BTEM2UTNXWEtoY3AxRVY4NTRw?=
 =?utf-8?B?dWVod1hDMTRzVWpNN2UyNzV2MjJ6bWVTTjEwWjVJUlprSVE3N1JlMHZXamM2?=
 =?utf-8?B?UmxLZ0djblRscEwvdGcwd3FlTGZWaDJodkpJSUN4Nys3WEJOc1JBQ0hkenZ0?=
 =?utf-8?B?ckR3UHNsVWZYMCtHWXlMSGM2V01SMEtEYXA4Q0dlRmhRbUk2bTlXRDAxSnBl?=
 =?utf-8?B?SzdJZWdyUEgrb21idHpLd2M5QklYYTBtWVVPWXFDOEpMMmhwWXBEU0RjN1Vy?=
 =?utf-8?B?djk4V2doQmxMSElpQVl6N1grUE5yWDJoRHJQdHFDeHBPVThuL1pvVEhDSG1w?=
 =?utf-8?B?OTRNN1BuV1ZseHlaR0Q1WTF6Qmg3MS91WWp0TWJPMEVWYkFtQm96ckJSMVg3?=
 =?utf-8?B?dXoraGRGNit1dGhUa0RDUUlEdXZqSTMybDYyR2FBRWlqOE5NNEhqSUQ2T2la?=
 =?utf-8?B?eFZNVzcyMGdoNjhWR3ZDZ0tEQ2VGMzRnaW5tbW55SDVjZ0ZseGZUbzJBdWlt?=
 =?utf-8?B?Yzl5bTltaXkxZmR6UTh4YnE2SldjSG80SGh6aExjdUFkQklnSStMU1k3ZEhk?=
 =?utf-8?B?R2dvSzVCMjR3bm5qVytENzdzamFMQTRzZHpZZE5naXNYbkZrVndTajRKdFdN?=
 =?utf-8?B?WS8yTmE2NUZhcW80c3NpY3B1eFdIQk9LTHFuUmc2V1VycFhDeVl3Q1ZIS2Q0?=
 =?utf-8?B?RjBhaFg1OW9XL3BBZ1NhaHFaN1JXaXdRYkxCYVVOMVlpNW5KMjd6WlVjblJh?=
 =?utf-8?B?UjNSdW5zbHh5YU9DVWU3M2JnWm1KZUp1VDJxQ3JTb3psTGhLakdhaXk1TTNV?=
 =?utf-8?B?MlBtdndVeFFNYnFzeHF0ZE5VQWxRWUEzemVuL3hZbFl2amFtK2w5dWJvbHBU?=
 =?utf-8?B?Zk1PdWl4MzVlQThEVytmSjZ3T25acW1Ua04wOTNyRmJDREZ3akhNcjNSMi9W?=
 =?utf-8?B?YWZZUC9OOUc3eWZTM0dMZDhUOHZIVC9ENTBpamRzV1orbG1IQ0hyZzQ4Zkhx?=
 =?utf-8?B?WHQ2UmNad21iNHZFV3gzZ2VtbmRxVkZnZElqcTBCbjk2a2FnNjFqRVk4V3pq?=
 =?utf-8?B?YjdQUzJDbmZDSFZPNDErTU5hcWpJVktPNkpVWHQyWGxEQUZUZjcrdEcyaDJZ?=
 =?utf-8?B?YVI2ckVQU2ZybXlDZ0ZZNWYwUytzM2RIYUdMckIxZkpIR0VaL084ZGszR1E0?=
 =?utf-8?B?SlBGUllhUytwTUMrTGtMbE5VOGJvYjZ1SU5zc2FlRy9Xd1FhR2ZtZVVTZVl1?=
 =?utf-8?B?Mm5DbDBxM3JOZE9MR2EyODlFWXdPcXpvaTFGQWZpaUEveTU3KzBNOTIyMFFk?=
 =?utf-8?B?THJTR3dSZ3FDQy9ERDVGMTZVNTNLMldCNVRJcEtXbEZjMVlLdzhQdWd3TkQ4?=
 =?utf-8?B?OTZ1KzJWWmYyb2oxZERpMnlzdTJiS21naWt4MGlVTGkvYWRlWmVZMWs5TG9J?=
 =?utf-8?B?cHJmUlNHTDRKYmRnSFFoZlNVS0xkdWlUdGFZZ3NkUmRPSlRRbTZoZkdBNEx0?=
 =?utf-8?B?dTM4bnVtVmlLYTBhY3lCNjdDb2Y2T1hJV1h3VEZmaGNxaTdFMDY0WGxuME85?=
 =?utf-8?B?MXg2UU80QVE2Z251K2xwbUFVNVFpbm1ldXpFQktNTjIzR05BSnNuSkdyeHh0?=
 =?utf-8?B?T3hlbjBuRFBvR1d3WWpZR3N3SFA3TW92bXEvZVU5aUVTaktYQnRKbUhTakx2?=
 =?utf-8?B?UzhJL3RWazVIWjhhOTJDK3VHc1RmTlRZZzdVNFU4Tjcybjl5dkgrV2hZNS9F?=
 =?utf-8?B?N3JKUEMvSlQ4YmV5WFRyWjl6SnE5SUg4UEZIaU5ZOTltc0lscjdNUExIWVd0?=
 =?utf-8?Q?/dXTyyVwUP4iU3Y29ZXYmyU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F15017CD9297CC48A2CB4AB1C4D7E358@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SG2PR03MB6415.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63a43b97-d605-44a3-87ec-08dcfa16b195
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Nov 2024 01:44:15.4929
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DOAwZqF2MfFU43hImjHTkTytNUXY2SHM2RyCtMGwg2d4wr7LjDR+z2AXy9uPrDdJvCp1liZV1edWx5dxGX3t+pwUz3ztxqEG9omQ1fzIeDQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB7526
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--25.664900-8.000000
X-TMASE-MatchedRID: 8HTFlOrbAtEOwH4pD14DsPHkpkyUphL9uPSKAaI54qHs+kHA3fqySiur
	x6gJh4oohFf4SrtHvFhVIaY0/108+AcSBA/LYDih9iItFUn3XkMjs7F41+YP7N9RlPzeVuQQxsr
	6m7RljBHv8kAqb9CJCLr+s9KgYfvYQdZuZ42vrpElAj6R+xEl2h9fNWA7SFWqt2rjS6M+VNnfaQ
	v/F9hswEZc638omEAxxMZLjCvtQbbCpGfpWZNAsjTR2TFg0xG3YtmTggNRdce9lorgztoFGJo1r
	HvDtypA14LBQFOA5GKe0ycch+70xH4dAQcikhqTYx1jPJKy+DzyVbjbSjLWDPCRnkWGAQw6nop5
	4kliwhpBht15nltLqpJGKw6pxwln4fEVvamOvhseOxBpKRngPYEcpMn6x9cZd71AOvz4tNxuJx8
	LEZUx93+H+u5hF9w5gj7Flj7SXGvgcE/Se4c9AZCB65RjRY3sLAnNohUyMa1IjvA1/YS+0ZsnGP
	/L/vukrSFdb18pjrB2U51zmt8pLl0U3RPW+iLPQIDtzftQ0iPHtFMYDLip2bv408/GP5HqbJe8t
	CaGGUxqBhzMI/uzM0DwPwupLH8nVjxQP9mlP0FZluvuHEedhJnaxzJFBx6vE+5bAfeaWuoBPILb
	nBTY1f1BNBACQf6mrzoNUtC8or4dVBXyH4TZjpF+9R8v7nzmOhJ9m53n4aBSIsssS3AbaKpZPjz
	zp8P+T+7I+/6MUDWi4phDigIRc6SUqefHzCIiMGAKZueP0maRPtwwl97omzeuSXk/Zc9nVObmG2
	y9ZkWuMZ3gmgaUtanN8UmQav9n9QpB8/MBSuOeAiCmPx4NwMFrpUbb72MU1B0Hk1Q1KyLUZxEAl
	FPo846HM5rqDwqtlExlQIQeRG0=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--25.664900-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	36FC0B3166EDD3C659F9D508A5BC6211EF3F7E8132D22417EE4C7B211F328CF52000:8

T24gVGh1LCAyMDI0LTEwLTMxIGF0IDE0OjI3IC0wNzAwLCBEb3VnIEFuZGVyc29uIHdyb3RlOg0K
PiBIaSwNCj4gDQo+IE9uIFdlZCwgT2N0IDMwLCAyMDI0IGF0IDEwOjAz4oCvUE0gUGF1bCBFLiBN
Y0tlbm5leSA8cGF1bG1ja0BrZXJuZWwub3JnPiB3cm90ZToNCj4gPiANCj4gPiA+ID4gPiBOb3Rl
IHRoYXQ6DQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gKiBTd2l0Y2hpbmcgdG8gcmVhbCBOTUlzIGlz
IGltcG9zc2libGUgb24gbWFueSBleGlzdGluZyBhcm02NCBDUFVzLg0KPiA+ID4gPiA+IFRoZSBo
YXJkd2FyZSBzdXBwb3J0IHNpbXBseSBpc24ndCB0aGVyZS4gUHNldWRvLU5NSXMgc2hvdWxkIHdv
cmsgZmluZQ0KPiA+ID4gPiA+IGFuZCBhcmUgKGluIG5lYXJseSBhbGwgY2FzZXMpIGp1c3QgYXMg
Z29vZCBhcyBOTUlzIGJ1dCB0aGV5IGhhdmUgYQ0KPiA+ID4gPiA+IHNtYWxsIHBlcmZvcm1hbmNl
IGltcGFjdC4gVGhlcmUgYXJlIGFsc28gY29tcGF0aWJpbGl0eSBpc3N1ZXMgd2l0aA0KPiA+ID4g
PiA+IHNvbWUgcHJlLWV4aXN0aW5nIGJvb3Rsb2FkZXJzLiAuLi5zbyBjb2RlIGNhbid0IGFzc3Vt
ZSBldmVuIFBzZXVkby1OTUkNCj4gPiA+ID4gPiB3aWxsIHdvcmsgYW5kIG5lZWRzIHRvIGJlIGFi
bGUgdG8gZmFsbCBiYWNrLiBQcmlvciB0byBteSByZWNlbnQNCj4gPiA+ID4gPiBjaGFuZ2VzIGFy
bTY0IENQVXMgd291bGRuJ3QgZXZlbiBkbyBzdGFja3RyYWNlcyBpbiBzb21lIHNjZW5hcmlvcy4g
Tm93DQo+ID4gPiA+ID4gYXQgbGVhc3QgdGhleSBmYWxsIGJhY2sgdG8gcmVndWxhciBJUElzLg0K
PiA+ID4gPiANCj4gPiA+ID4gQnV0IHRob3NlIElQSXMgYXJlIG9mIG5vIGhlbHAgd2hhdHNvZXZl
ciB3aGVuIHRoZSB0YXJnZXQgQ1BVIGlzIHNwaW5uaW5nDQo+ID4gPiA+IHdpdGggaW50ZXJydXB0
cyBkaXNhYmxlZCwgd2hpY2ggaXMgdGhlIHNjZW5hcmlvIHVuZGVyIGRpc2N1c3Npb24uDQo+ID4g
PiANCj4gPiA+IFJpZ2h0IHRoYXQgd2UgY2FuJ3QgdHJhY2UgdGhlIHRhcmdldCBDUFUgc3Bpbm5p
bmcgd2l0aCBpbnRlcnJ1cHRzDQo+ID4gPiBkaXNhYmxlZC4NCj4gPiANCj4gPiBZb3UgY2FuIGJ5
IGludm9raW5nIHNjaGVkX3Nob3dfdGFzayhjcHVfY3VycihjcHUpKSBvbiB0aGUgQ1BVIHJlcXVl
c3RpbmcNCj4gPiB0aGUgYmFja3RyYWNlLiAgVGhlIHJlc3VsdGluZyBiYWNrdHJhY2Ugd2lsbCBu
b3QgYmUgYXMgZ29vZCBhcyB5b3UNCj4gPiB3b3VsZCBnZXQgZnJvbSB1c2luZyBhbiBOTUksIGJ1
dCBpZiB5b3UgZG9uJ3QgaGF2ZSBOTUlzLCBpdCBpcyBiZXR0ZXINCj4gPiB0aGFuIG5vdGhpbmcu
DQo+ID4gDQo+ID4gPiAgICAgICAgICAgLi4uYnV0IGluIHRoZSBjYXNlIHdoZXJlIE5NSSBpc24n
dCBhdmFpbGFibGUgaXQgX3N0aWxsXw0KPiA+ID4gbWFrZXMgc2Vuc2UgdG8gbWFrZSBhcmNoX3Ry
aWdnZXJfY3B1bWFza19iYWNrdHJhY2UoKSBmYWxsIGJhY2sgdG8gSVBJDQo+ID4gPiBiZWNhdXNl
Og0KPiA+ID4gDQo+ID4gPiAxLiBUaGVyZSBhcmUgbWFueSBjYXNlcyB3aGVyZSB0aGUgdHJpZ2dl
ci4qY3B1LipiYWNrdHJhY2UoKSBjbGFzcyBvZg0KPiA+ID4gZnVuY3Rpb25zIGFyZSB1c2VkIHRv
IHRyYWNlIENQVXMgdGhhdCBfYXJlbid0XyBsb29waW5nIHdpdGggaW50ZXJydXB0cw0KPiA+ID4g
ZGlzYWJsZWQuIFdlIHN0aWxsIHdhbnQgdG8gYmUgYWJsZSB0byBiYWNrdHJhY2UgaW4gdGhhdCBj
YXNlLiBGb3INCj4gPiA+IGluc3RhbmNlLCB5b3UgY2FuIHNlZSBpbiAicGFuaWMuYyIgdGhhdCB0
aGVyZSBhcmUgY2FzZXMgd2hlcmUNCj4gPiA+IHRyaWdnZXJfYWxsX2NwdV9iYWNrdHJhY2UoKSBp
cyBjYWxsZWQuIEl0J3MgdmFsdWFibGUgdG8gbWFrZSBjYXNlcw0KPiA+ID4gbGlrZSB0aGlzICh3
aGVyZSB0aGVyZSdzIG5vIGluZGljYXRpb24gdGhhdCBhIENQVSBpcyBsb2NrZWQpIGFjdHVhbGx5
DQo+ID4gPiB3b3JrLg0KPiA+ID4gDQo+ID4gPiAyLiBFdmVuIGlmIHRoZXJlJ3MgYSBDUFUgdGhh
dCdzIGxvb3Bpbmcgd2l0aCBpbnRlcnJ1cHRzIGRpc2FibGVkIGFuZA0KPiA+ID4gd2UgY2FuJ3Qg
dHJhY2UgaXQgYmVjYXVzZSBvZiBubyBOTUksIGl0IGNvdWxkIHN0aWxsIGJlIHVzZWZ1bCB0byBn
ZXQNCj4gPiA+IGJhY2t0cmFjZXMgb2Ygb3RoZXIgQ1BVcy4gSXQncyBwb3NzaWJsZSB0aGF0IHdo
YXQgdGhlIG90aGVyIENQVXMgYXJlDQo+ID4gPiBkb2luZyBjb3VsZCBnaXZlIGEgaGludCBhYm91
dCB0aGUgQ1BVIHRoYXQncyB3ZWRnZWQuIFRoaXMgaXNuJ3QgYQ0KPiA+ID4gZ3JlYXQgaGludCwg
YnV0IHNvbWUgaW5mbyBpcyBiZXR0ZXIgdGhhbiBubyBpbmZvLg0KPiA+IA0KPiA+IEFuZCBpdCBh
bHNvIG1ha2VzIHNlbnNlIGZvciBhbiBJUlEtYmFzZWQgYmFja3RyYWNlIHRvIGZhbGwgYmFjayB0
bw0KPiA+IHNvbWV0aGluZyBsaWtlIHRoZSBhZm9yZW1lbnRpb25lZCBzY2hlZF9zaG93X3Rhc2so
Y3B1X2N1cnIoY3B1KSkgaWYNCj4gPiB0aGUgZGVzdGluYXRpb24gQ1BVIGhhcyBpbnRlcnJ1cHRz
IGRpc2FibGVkLg0KPiA+IA0KPiA+ID4gPiBIZW5jZSBteSBzdWdnZXN0aW9uIHRoYXQgYXJtNjQs
IHdoZW4gdXNpbmcgSVJRcyB0byByZXF1ZXN0IHN0YWNrDQo+ID4gPiA+IGJhY2t0cmFjZXMsIGhh
dmUgYW4gYWRkaXRpb25hbCBzaG9ydCB0aW1lb3V0IChtaWxsaXNlY29uZHMpIGluDQo+ID4gPiA+
IG9yZGVyIHRvIGZhbGwgYmFjayB0byByZW1vdGUgc3RhY2sgdHJhY2luZy4gIEluIG1hbnkgY2Fz
ZXMsIHRoaXMNCj4gPiA+ID4gZmFsbGJhY2sgaGFwcGVucyBhdXRvbWF0aWNhbGx5LCBhcyB5b3Ug
Y2FuIHNlZSBpbiBkdW1wX2NwdV90YXNrKCkuDQo+ID4gPiA+IElmIHRyaWdnZXJfc2luZ2xlX2Nw
dV9iYWNrdHJhY2UoKSByZXR1cm5zIGZhbHNlLCB0aGUgc3RhY2sgaXMgZHVtcGVkDQo+ID4gPiA+
IHJlbW90ZWx5Lg0KPiA+ID4gDQo+ID4gPiBJIHRoaW5rIHRoZSBhbnN3ZXIgaGVyZSBpcyB0aGF0
IHRoZSBBUEkgbmVlZHMgdG8gY2hhbmdlLiBUaGUgd2hvbGUNCj4gPiA+IGJvb2xlYW4gcmV0dXJu
IHZhbHVlIGZvciB0cmlnZ2VyLipjcHUuKmJhY2t0cmFjZSgpIGlzIG1vc3RseSBpZ25vcmVkDQo+
ID4gPiBieSBjYWxsZXJzLiBZZXMsIHlvdSd2ZSBwb2ludGVkIGF0IG9uZSBvZiB0aGUgdHdvIHBs
YWNlcyB0aGF0IGl0J3Mgbm90DQo+ID4gPiBpZ25vcmVkIGFuZCBpdCB0cmllcyBhIHJlYXNvbmFi
bGUgZmFsbGJhY2ssIGJ1dCBhbGwgdGhlIG90aGVyIGNhbGxlcnMNCj4gPiA+IGp1c3Qgc2lsZW50
bHkgZG8gbm90aGluZyB3aGVuIHRoZSBmdW5jdGlvbiByZXR1cm5zIGZhbHNlLiBUaGF0IGxlZCB0
bw0KPiA+ID4gbWFueSBwbGFjZXMgd2hlcmUgYXJtNjQgZGV2aWNlcyB3ZXJlIHNpbXBseSBub3Qg
Z2V0dGluZyBfYW55Xw0KPiA+ID4gc3RhY2t0cmFjZS4NCj4gPiA+IA0KPiA+ID4gUGVyaGFwcyB3
ZSBuZWVkIHNvbWUgdHlwZSBvZiBBUEkgdGhhdCBzYXlzICJJIGFjdHVhbGx5IGhhdmUgYQ0KPiA+
ID4gZmFsbGJhY2ssIHNvIGlmIHlvdSBkb24ndCB0aGluayB0aGUgc3RyYWNrdHJhY2Ugd2lsbCBz
dWNjZWVkIHRoZW4gaXQncw0KPiA+ID4gT0sgdG8gcmV0dXJuIGZhbHNlIi4NCj4gPiANCj4gPiBC
b29sZWFuIGlzIGZpbmUgZm9yIHRyaWdnZXJfc2luZ2xlX2NwdV9iYWNrdHJhY2UoKSwgd2hpY2gg
aXMgZGlyZWN0ZWQgYXQNCj4gPiBhIHNpbmdsZSBDUFUuICBBbmQgdGhlIG9uZSBjYWxsIHRvIHRo
aXMgZnVuY3Rpb24gdGhhdCBkb2VzIG5vdCBjdXJyZW50bHkNCj4gPiBjaGVjayBpdHMgcmV0dXJu
IHZhbHVlIGNvdWxkIGp1c3QgY2FsbCBkdW1wX2NwdV90YXNrKCkgaW5zdGVhZC4NCj4gPiANCj4g
PiBUaGVyZSBhcmUgb25seSAyMCBvciBzbyB1c2VzIG9mIGFsbCBvZiB0aGVzZSBmdW5jdGlvbnMs
IHNvIHRoZSBBUEkgY2FuDQo+ID4gY2hhbmdlLCBnaXZlIG9yIHRha2UgdGhlIHBhaW4gaW52b2x2
ZWQgaW4gY2hhbmdpbmcgYXJjaGl0ZWN0dXJlLXNwZWNpZmljDQo+ID4gY29kZS4NCj4gDQo+IFJp
Z2h0LiBGYWxsaW5nIGJhY2sgdG8gInNjaGVkX3Nob3dfdGFzayhjcHVfY3VycihjcHUpKSIgb3Ig
c29tZXRoaW5nDQo+IHNpbWlsYXIgaWYgdGhlIElQSSBkb2Vzbid0IGdvIHRocm91Z2ggaXMgYSBn
b29kIGlkZWEuIEluZGVlZCwgZmFsbGluZw0KPiBiYWNrIHRvIHRoYXQgaWYgdGhlIE5NSSBkb2Vz
bid0IGdvIHRocm91Z2ggaXMgX2Fsc29fIGEgZ29vZCBpZGVhLA0KPiByaWdodD8gLi4uYW5kIHdl
IGRvbid0IHdhbnQgdG8gY2hhbmdlIGFsbCAyMCBjYWxsZXJzIHRvIGFsbCBhZGQgYQ0KPiBmYWxs
YmFjay4gVG8gdGhhdCBlbmQsIGl0IGZlZWxzIGxpa2Ugc29tZW9uZSBzaG91bGQgY2hhbmdlIGl0
IHNvIHRoYXQNCj4gdGhlIGNvbW1vbiBjb2RlIGluY2x1ZGVzIHRoZSBmYWxsYmFjayBhbmQgd2Ug
Z2V0IHJpZCBvZiB0aGUgYm9vbGVhbg0KPiByZXR1cm4gdmFsdWUuDQo+IA0KPiA+ID4gPiA+ICog
RXZlbiBpZiB3ZSBkZWNpZGVkIHRoYXQgd2UgYWJzb2x1dGVseSBoYWQgdG8gZGlzYWJsZSBzdGFj
a3RyYWRlcyBvbg0KPiA+ID4gPiA+IGFybTY0IENQVXMgd2l0aG91dCBzb21lIHR5cGUgb2YgTk1J
LCB0aGF0IHdvbid0IGZpeCBhcm0zMi4gYXJtMzIgaGFzDQo+ID4gPiA+ID4gYmVlbiB1c2luZyBy
ZWd1bGFyIElQSXMgZm9yIGJhY2t0cmFjZXMgbGlrZSB0aGlzIGZvciBtYW55LCBtYW55IHllYXJz
Lg0KPiA+ID4gPiA+IE1heWJlIGZvbGtzIGRvbid0IGNhcmUgYXMgbXVjaCBhYm91dCBhcm0zMiBh
bnltb3JlIGJ1dCBpdCBmZWVscyBiYWQgaWYNCj4gPiA+ID4gPiB3ZSB0b3RhbGx5IGJyZWFrIGl0
Lg0KPiA+ID4gPiANCj4gPiA+ID4gQmVjYXVzZSBhcm0zMiBpc24ndCB1c2VkIG11Y2ggZm9yIGRh
dGFjZW50ZXIgd29ya2xvYWRzLCBpdCB3aWxsIG5vdA0KPiA+ID4gPiBiZSBzdWZmZXJpbmcgZnJv
bSB0aGlzIGlzc3VlLiAgTm90IGVub3VnaCB0byBoYXZlIG1vdGl2YXRlZCBhbnlvbmUgdG8NCj4g
PiA+ID4gZml4IGl0LCBhbnl3YXkuICBJbiBjb250cmFzdCwgaW4gdGhlIGRhdGFjZW50ZXIsIENQ
VXMgcmVhbGx5IGNhbiBhbmQNCj4gPiA+ID4gZG8gaGF2ZSBpbnRlcnJ1cHRzIGRpc2FibGVkIGZv
ciBtYW55IHNlY29uZHMuICAoTm8sIHRoaXMgaXMgbm90IGEgZ29vZA0KPiA+ID4gPiB0aGluZywg
YnV0IGl0IGlzIGNvbW1vbiBlbm91Z2ggZm9yIHVzIHRvIG5lZWQgdG8gYXZvaWQgZGlzYWJsaW5n
IG90aGVyDQo+ID4gPiA+IGRlYnVnZ2luZyBmYWNpbGl0aWVzLikNCj4gPiA+ID4gDQo+ID4gPiA+
IFNvIGl0IG1pZ2h0IHdlbGwgYmUgdGhhdCBhcm0zMiB3aWxsIGNvbnRpbnVlIHRvIGRvIGp1c3Qg
ZmluZSB3aXRoDQo+ID4gPiA+IElSUS1iYXNlZCBzdGFjayB0cmFjaW5nLiAgT3IgbWF5YmUgc29t
ZWRheSBhcm0zMiB3aWxsIGFsc28gbmVlZCB0byBkZWFsDQo+ID4gPiA+IHdpdGggdGhpcyBzYW1l
IGlzc3VlLiAgQnV0IG5vICJtYXliZSIgZm9yIGFybTY0LCBnaXZlbiBpdHMgaW5jcmVhc2luZw0K
PiA+ID4gPiB1c2UgaW4gdGhlIGRhdGFjZW50ZXIuDQo+ID4gPiANCj4gPiA+IElNTyB0aGUgYW5z
d2VyIGhlcmUgaXMgdGhhdCBhbnlvbmUgaW4gZGF0YWNlbnRlcnMgc2hvdWxkIGp1c3QgdHVybiBv
bg0KPiA+ID4gcHNldWRvIE5NSSAob3IgTk1JIG9uIG5ld2VyIGFybTY0IENQVXMpLg0KPiA+IA0K
PiA+IFN1cHBvc2UgZGF0YWNlbnRlcnMgYWxsIGRvIHRoaXMuICBXaGF0IHBhcnQgb2YgdGhpcyBp
c3N1ZSByZW1haW5zPw0KPiANCj4gSSBiZWxpZXZlIHRoYXQgaWYgZGF0YWNlbnRlcnMgZW5hYmxl
IHBzZXVkbyBOTUlzIHRoZW4gdGhlIGlzc3VlIGlzDQo+ICJmaXhlZCIgYW5kIHRodXMgb25seSBy
ZW1haW5zIGZvciBhbnlvbmUgZWxzZSAoZGF0YWNlbnRlcnMgb3Igb3RoZXINCj4gdXNlcnMgb2Yg
TGludXgpIHRoYXQgZG9uJ3QgdHVybiBvbiBwc2V1ZG8gTk1Jcy4NCj4gDQo+IA0KPiA+ID4gPiA+
IElNTyB3YWl0aW5nIDEwIHNlY29uZHMgZm9yIGEgYmFja3RyYWNlIGlzIHByZXR0eSBjcmF6eSB0
byBiZWdpbiB3aXRoLg0KPiA+ID4gPiA+IFdoYXQgYWJvdXQganVzdCBjaGFuZ2luZyB0aGF0IGds
b2JhbGx5IHRvIDEgc2Vjb25kPyBJZiBub3QsIGl0IGRvZXNuJ3QNCj4gPiA+ID4gPiBmZWVsIGxp
a2UgaXQgd291bGQgYmUgaW1wb3NzaWJseSBoYXJkIHRvIG1ha2UgYW4gYXJjaC1zcGVjaWZpYw0K
PiA+ID4gPiA+IGNhbGxiYWNrIHRvIGNob29zZSB0aGUgdGltZSBhbmQgdGhhdCBjYWxsYmFjayBj
b3VsZCBldmVuIHRha2UgaW50bw0KPiA+ID4gPiA+IGFjY291bnQgd2hldGhlciB3ZSBtYW5hZ2Vk
IHRvIGdldCBhbiBOTUkuIEknZCBiZSBoYXBweSB0byByZXZpZXcgc3VjaA0KPiA+ID4gPiA+IGEg
cGF0Y2guDQo+ID4gPiA+IA0KPiA+ID4gPiBMZXQncyBwbGVhc2Uga2VlcCB0aGUgMTAtc2Vjb25k
IHRpbWVvdXQgZm9yIE5NSS1iYXNlZCBiYWNrdHJhY2VzLg0KPiA+ID4gPiANCj4gPiA+ID4gQnV0
IEkgdGFrZSBpdCB0aGF0IHlvdSBhcmUgbm90IG9wcG9zZWQgdG8gYSBzaG9ydGVyIHRpbWVvdXQg
Zm9yIHRoZQ0KPiA+ID4gPiBzcGVjaWFsIGNhc2Ugb2YgSVJRLWJhc2VkIHN0YWNrIGJhY2t0cmFj
ZSByZXF1ZXN0cz8NCj4gPiA+IA0KPiA+ID4gSU1PIHRoZSAxMCBzZWNvbmQgaXMgc3RpbGwgYXdm
dWxseSBsb25nIChIVyB3YXRjaGRvZ3MgY2FuIHRyaWdnZXINCj4gPiA+IGR1cmluZyB0aGF0IHRp
bWUpLCBidXQgSSdtIG5vdCB0aGF0IHVwc2V0IGJ5IGl0LiBJJ20gT0sgd2l0aCBzaG9ydGVyDQo+
ID4gPiB0aW1lb3V0cyBmb3IgSVJRLWJhc2VkIG9uZXMsIHRob3VnaCBJJ20gbm90IHN1cmUgSSdk
IGJlIE9LIHcvIHRpbWVvdXRzDQo+ID4gPiBtZWFzdXJlZCBpbiBtaWxsaXNlY29uZHMgdW5sZXNz
IHRoZSBjYWxsZXIgaGFzIGFjdHVhbGx5IHNhaWQgdGhhdCB0aGV5DQo+ID4gPiBjYW4gaGFuZGxl
IGEgImZhbHNlIiByZXR1cm4gb3IgdGhlIGNhbGxlciBzYXlzIHRoYXQgaXQncyBtb3JlDQo+ID4g
PiBpbXBvcnRhbnQgdG8gYmUgcXVpY2sgdGhhbiB0byB3YWl0IGZvciBhIGxvbmcgdGltZS4NCj4g
PiANCj4gPiBJZiB5b3UgYXJlIHVzaW5nIE5NSXMsIGFuZCB0aGUgQ1BVIGRvZXNuJ3QgcmVzcG9u
ZCBpbiAxMCBzZWNvbmRzLA0KPiA+IHNvbWV0aGluZyBpcyBsaWtlbHkgYnJva2VuLiAgTWF5YmUg
YmFkIGZpcm13YXJlIG9yIGJhZCBoYXJkd2FyZS4gIFlvdSBhcmUNCj4gPiByaWdodCB0aGF0IHdh
dGNoZG9ncyBtaWdodCB0cmlnZ2VyLCBidXQgdGhleSBhcmUgbGlrZWx5IGFscmVhZHkgdHJpZ2dl
cmluZw0KPiA+IGR1ZSB0byB0aGUgdGFyZ2V0IENQVSBiZWluZyBzbyBmaXJtbHkgbG9ja2VkIHVw
IHRoYXQgaXQgaXMgbm90IHJlc3BvbmRpbmcNCj4gPiBldmVuIHRvIE5NSXMuDQo+IA0KPiBZZWFo
LCBpZiBOTUlzIGFyZW4ndCB3b3JraW5nIHRoZW4gdGhpbmdzIGFyZSBwcmV0dHkgYmFkLiBJdCBz
dGlsbA0KPiBzZWVtcyBsaWtlIGl0IHdvdWxkIGJlIGJldHRlciB0byBsZXQgTGludXggZHVtcCBt
b3JlIGluZm8gYmVmb3JlIGENCj4gaGFyZHdhcmUgd2F0Y2hkb2cgdHJpZ2dlcnMuIEZvciBpbnN0
YW5jZSBpdCBjb3VsZCBwZXJoYXBzIGNhbGwNCj4gc29tZXRoaW5nIGFraW4gdG8gInNjaGVkX3No
b3dfdGFzayhjcHVfY3VycihjcHUpKSIuDQo+IA0KPiBJIGRvbid0IGZlZWwgc3VwZXIgc3Ryb25n
bHkgYWJvdXQgaXQsIGJ1dCBpbiBteSBtaW5kIGV2ZW4gaWYgYSBDUFUgaXMNCj4gdW5yZXNwb25z
aXZlIHRvIE5NSXMgZm9yIDEtMiBzZWNvbmRzIHRoZW4gdGhpbmdzIGFyZSBpbiBwcmV0dHkgYmFk
DQo+IHNoYXBlIGFuZCBJJ2Qgd2FudCB0byBzdGFydCBkdW1waW5nIHNvbWUgbW9yZSBpbmZvIGJl
Zm9yZSB0aGUgaGFyZHdhcmUNCj4gd2F0Y2hkb2cga2lja3MgaW4gYW5kIHdlIGNhbid0IGR1bXAg
YW55dGhpbmcuDQo+IA0KPiANCj4gPiBPbiB0aGUgb3RoZXIgaGFuZCwgd2hlbiB5b3UgYXJlIG5v
dCB1c2luZyBOTUlzLCB0aGVuIEkgYWdyZWUNCj4gPiB5b3Ugd2FudCBhIHNob3J0ZXIgdGltZW91
dCBiZWZvcmUgcmVtb3RlbHkgdHJhY2luZyB0aGUgc3RhZWsgdmlhDQo+ID4gc2NoZWRfc2hvd190
YXNrKGNwdV9jdXJyKGNwdSkpLiAgSSBwaWNrZWQgYSBmZXcgbWlsbGlzZWNvbmRzLCBidXQgaWYN
Cj4gPiBkYXRhY2VudGVycyBhcmUgdXNpbmcgcmVhbCBOTUlzIG9yIHBzZXVkbyBOTUlzIChhbmQg
dGh1cyBhcmUgbm90IGJlaW5nDQo+ID4gYmxvY2tlZCBieSBub3JtYWwgaW50ZXJydXB0IGRpc2Fi
bGluZyksIHRoZW4gSSBtdXN0IGRlZmVyIHRvIG90aGVycyBvbg0KPiA+IHRoZSBkZWZhdWx0IHRp
bWVvdXQuICBNdWNoIGRlcGVuZHMgb24gdGhlIHdvcmtsb2FkIGFuZCBjb25maWd1cmF0aW9uLg0K
PiANCj4gQXMgSSBzYWlkLCBJIGRvbid0IGZlZWwgc3Ryb25nbHkgYWJvdXQgdGhpcywgc28gaWYg
cGVvcGxlIHdhbnQgdG8ga2VlcA0KPiB0aGUgdGltZW91dCBvciBzaG9ydGVuIGl0IG9yIGFkZCBh
IGtub2IsIGFueSBvZiB0aG9zZSB3b3VsZCBiZSBmaW5lDQo+IHdpdGggbWUuIEkgcGVyc29uYWxs
eSB3b3VsZCBvYmplY3QgdG8gYSB0aW1lb3V0IHRoYXQncyBfdG9vXyBzaG9ydCBvcg0KPiBhIHRp
bWVvdXQgdGhhdCBpcyBsb25nZXIgdGhhbiB0aGUgY3VycmVudCAxMCBzZWNvbmRzLg0KPiANCj4g
LURvdWcNCg0KSSBob3BlIHRoaXMgZml4IGNhbiBiZSBhcHBsaWVkIHRvIHRoZSBzdGFibGUga2Vy
bmVscy4gTW9kaWZ5aW5nIGFuIEFQSQ0KdGhhdCBpcyBjYWxsZWQgYnkgbWFueSBhcmNoaXRlY3R1
cmVzIG1heSBlbmNvdW50ZXIgZGlmZmljdWx0aWVzIGR1cmluZw0KdGhlIGJhY2twb3J0aW5nIHBy
b2Nlc3MuDQoNCkhvdyBhYm91dCB0aGlzOiB3ZSBrZWVwIHRoZSBvcmlnaW5hbCBubWlfdHJpZ2dl
cl9jcHVtYXNrX2JhY2t0cmFjZSgpDQpidXQgYWRkIGEgX19ubWlfdHJpZ2dlcl9jcHVtYXNrX2Jh
Y2t0cmFjZSgpIGluIHRoZSBtaWRkbGUgdGhhdCBjYW4NCmFjY2VwdCBhIHRpbWVvdXQgcGFyYW1l
dGVyLg0KDQoNCisjZGVmaW5lIE5NSV9CQUNLVFJBQ0VfVElNRU9VVCAoMTAgKiAxMDAwKQ0KDQp2
b2lkIG5taV90cmlnZ2VyX2NwdW1hc2tfYmFja3RyYWNlKC4uLikNCit7DQorCV9fbm1pX3RyaWdn
ZXJfY3B1bWFza19iYWNrdHJhY2UoLi4uLCBOTUlfQkFDS1RSQUNFX1RJTUVPVVQpOw0KK30NCisN
Cit2b2lkIF9fbm1pX3RyaWdnZXJfY3B1bWFza19iYWNrdHJhY2UoLi4uLCB1bnNpZ25lZCBsb25n
IHRpbWVvdXQpDQp7DQouLi4NCi0JZm9yIChpID0gMDsgaSA8IDEwICogMTAwMDsgaSsrKSB7DQor
CWZvciAoaSA9IDA7IGkgPCB0aW1lb3V0OyBpKyspIHsNCg0KDQpUaGVuLCB0aGUgYXJjaF90cmln
Z2VyX2NwdW1hc2tfYmFja3RyYWNlKCkgZm9yIGRpZmZlcmVudCBhcmNoaXRlY3R1cmVzDQpjYW4g
cGFzcyBpbiB0aGVpciBkZXNpcmVkIHRpbWVvdXQsIGZvciBleGFtcGxlOg0KDQoJLyogMSBzZWNv
bmRzIGlmIGZhbGxiYWNrZWQgdG8gSVBJICovDQoJdGltZW91dCA9IGhhc19ubWkoKSA/IE5NSV9C
QUNLVFJBQ0VfVElNRU9VVCA6IDEwMDA7DQoJX19ubWlfdHJpZ2dlcl9jcHVfbWFza19iYWNrdHJh
Y2UoLi4uLCB0aW1lb3V0KTsNCg0KVGhpcyB3YXksIGFyY2hpZWN0dXJlcyB0aGF0IHdhbnQgZGlm
ZmVyZW50IHRpbWVvdXRzIGNhbiBtb2RpZnkgaXQNCnRoZW1zZWx2ZXMgd2l0aG91dCBoYXZpbmcg
dG8gaW1wbGVtZW50IGNvbXBsZXggbG9naWMgb24gdGhlaXIgb3duLg0KDQotQ2hlbmctSnVpDQoN
Cg==

