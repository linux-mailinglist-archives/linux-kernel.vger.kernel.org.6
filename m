Return-Path: <linux-kernel+bounces-434713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 591E79E6A10
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 10:29:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 149BC2829FB
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 09:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB0CD1E1322;
	Fri,  6 Dec 2024 09:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="t7Yt8mjG";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="psi0/b7B"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD37E1C3F2C
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 09:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733477342; cv=fail; b=Y3OjrCHC6m/RenVUK4fHdf2HdblaQO2YqcWerbnZZln+Ep6z7c1VClLvBvfx27O9QpWQsXKDZPxCvWl9ZOFx8LczF5rpymcqjiw7UdvdZHt5qi8NJYpJMCcEPdTmEnddkJeumbjBDVm2/8cBgNGqB3/PcC3rjgRA1ovf/9jU6T4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733477342; c=relaxed/simple;
	bh=+taoXtmJaEqyki5gS4SGvx+j1GvbmnIwg0Dsf6nEXvw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BwmhV7Z08xSzH0HTGWMlsZmadi3OmjFn7MVcuJvGtrKJAMQUdLiCTOe6oF4YlUh0dOV80fRkRhRgAO/Tfrfev3DMNbFrQ94vFVsTWdomyn/HDwH2bAIjZHnk6DICALmXvmq1NUGbnRAuA46ReE7KgX9kUxqfnB1h6PbLrmXDWS4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=t7Yt8mjG; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=psi0/b7B; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 82b25184b3b411efbd192953cf12861f-20241206
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=+taoXtmJaEqyki5gS4SGvx+j1GvbmnIwg0Dsf6nEXvw=;
	b=t7Yt8mjGmQf3KmGQcT6hbVHm+6xcl924Qo3+TRqOwlmGUwDf1Tq2Ok/dmdDHaR159Ll07mGQjHIk7A9tP4MXI6FD3RPudhN2dTncIEJ6eEnENdJ+D42gs3hQZCTryL7HrFpcDBp203FoEDnEVOtArfQsTrjd1U0yE2QQSVHUdQQ=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:f486d341-18a6-4196-97cd-46e4f0e302c5,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6493067,CLOUDID:1eca8a3b-e809-4df3-83cd-88f012b9e9ba,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0,EDM
	:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0
	,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 82b25184b3b411efbd192953cf12861f-20241206
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw02.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 374491363; Fri, 06 Dec 2024 17:28:53 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 6 Dec 2024 17:28:52 +0800
Received: from HK2PR02CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 6 Dec 2024 17:28:52 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wj0XopRPUuLkGcAEWcnYd4fr3jBU8AfGyr5xvXV4O3CCpmIaymkf+ulVbAVFuItEKYr0emzfFIctXUtKq3Hefn5PVqXGZrF8L6CIgOKg3r5rROu5X+uamymWC79YmCUMYRAPmwuXQGD3IFThElHUi2LjqjvRM93rr9QjUOWhzU7i/vZdTF2AUPNAs0cdaLeZrwZPOxrl67Ri7ttcMsiIJdA0ic9RPJ05sZL5i7JLD4pFZ2CauJpe0Y1FrJcKuXosx1SRPptz/JhsgVyCY+Xq31K3Gp4d9YFwork9DBRRdAwqiVUUAQ1y4BuP1hnE9bhkDIO7y5m19iOPXjhezfPIHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+taoXtmJaEqyki5gS4SGvx+j1GvbmnIwg0Dsf6nEXvw=;
 b=R2ZSEoes79YoJqxBTYxX52s9RFjPEr88Ptz6aRU+z2aIuj3PnsnX/j1/03D5PPc1hzW6o2IOvODep8Ii7mJGEWlfRjhubA666ThgWJ+VOqdSdp0/snL/R96BdyLfZuYgyCl6PYIsNzNpKnrgubKqrD66gAZD4cQrY7iLwk2ZNdsj11YfRWjQt985BxTbk/qm6a7EAXRItROyYCM+eBmxxaJMzZXxUwWzvSFR+NJv3+heJgp90VHOb8naKOzO47a0ArGr8BoyL6iCCLMUOpTWOZyfUcGAk3AA7wNhwFuHgca+C3tOctA6bzcxBa7pzBaihFX4QystycPfa8iwfv/uPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+taoXtmJaEqyki5gS4SGvx+j1GvbmnIwg0Dsf6nEXvw=;
 b=psi0/b7B1FAkSFaNCvN8z+enlWsLHQ4LFtUb+tgQR/3gy4L8BGM4rcadYPRsIPFTixqxIjt52jW7yEbtm0stZ4f6UDN5BGCvT2YcmPHFpGGaB3S1IDS9x3RBmR1BP04POzFzXUWgFxEAzNhno23L5ELvWEIdE4U3QCGEN8O+4fI=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by TYZPR03MB7668.apcprd03.prod.outlook.com (2603:1096:400:41a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.10; Fri, 6 Dec
 2024 09:28:48 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54%3]) with mapi id 15.20.8207.014; Fri, 6 Dec 2024
 09:28:48 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= <Jason-JH.Lin@mediatek.com>,
	"chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>
CC: =?utf-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= <Singo.Chang@mediatek.com>,
	Project_Global_Chrome_Upstream_Group
	<Project_Global_Chrome_Upstream_Group@mediatek.com>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	=?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>, "fshao@chromium.org"
	<fshao@chromium.org>, =?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?=
	<Shawn.Sung@mediatek.com>
Subject: Re: [PATCH v2] drm/mediatek: Move mtk_crtc_finish_page_flip() to
 ddp_cmdq_cb()
Thread-Topic: [PATCH v2] drm/mediatek: Move mtk_crtc_finish_page_flip() to
 ddp_cmdq_cb()
Thread-Index: AQHbOqFbl7JexUeX102lLTjyjM6Di7LZDT2A
Date: Fri, 6 Dec 2024 09:28:47 +0000
Message-ID: <c0092a07a9e6d0bc9b2dc85f379e6cddfa095ef7.camel@mediatek.com>
References: <20241119163658.31405-1-jason-jh.lin@mediatek.com>
In-Reply-To: <20241119163658.31405-1-jason-jh.lin@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|TYZPR03MB7668:EE_
x-ms-office365-filtering-correlation-id: f29f07e6-c1b2-4d20-a42f-08dd15d86355
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?bmlYVjlrT2VqczRkR2tJVFB6TTFabGdRS04weENzUTdJN0FOY0UvTFdPOUg2?=
 =?utf-8?B?MHV2RzRuWmo2TVFiU1lZdW5oUVhjaUEvQ0t1N0t6RXRUVDNBNWhmZ2kwV0dt?=
 =?utf-8?B?TzB0akQ1NUw2elpNWldNU1BHem1MSmdSbEJUNTNZZmxJWlZyUEpMQ3NXU3RK?=
 =?utf-8?B?YWZZc0VtNVRCQnZPRGFKc0VzM3RkeWRiTzI5U2lGRUQ0UEc4VWJiWXg1R1BG?=
 =?utf-8?B?WVY4bGJzaDFrZmtlVVZjeUNNSmdSRnVQSXd4ZGc5K2Y3SzViM2pnOElRVGxr?=
 =?utf-8?B?Q2c0K2h6SHVxb2FDejFpcmt1ZHVZOFhmVTJZWThKaHBkSXBxUERkKzhuMGlo?=
 =?utf-8?B?WFBnUUtFTXhNUk5hTzBURVo0bStSQ3J6NFNNRUhWam1wclZyL0ZxRFRYRUhU?=
 =?utf-8?B?NUpCcklRSkMwYjUyRWlsUmZMOHdaWlo0TDFaZUxKbU1GbkhSMVRoV3NrbUQ4?=
 =?utf-8?B?VEJ1eGZSVEl6cko3MnAwRXJUdWdGRjhoLzJURXFzYlRrTzMyL0RGOTZJL1V5?=
 =?utf-8?B?dUs5OTBPM0FxcWpacnBNSERXNW5NMGZkVi9Ld1RrTkt1RS9Zb3p1ci9JYndq?=
 =?utf-8?B?Q2dCRnNGdUNPNzFRbjlOSWhQMTRXcDdRTnowb3JQV0RvOTZMYXcvSy8wZkkz?=
 =?utf-8?B?TVF1NW95OXNScHIwbEx2UlZ3OWpZcHFPTzJrVUV3S3JZMGZXQjFDcGh1NWFO?=
 =?utf-8?B?SzZQT3JqRWp6K2ZZVU5CbDFISkQ3UnRTa3RQRVRkQ0hkL25EaFlKWHpZdG5U?=
 =?utf-8?B?UFMwR0tpZDZ4N0J1MlZOU1lKWHZVVnBRZG5XcjFmbTVzS1BSeGYxVk9tUTY3?=
 =?utf-8?B?L2tqTHZtTU5WRUFadU1hbmZWUjJrNndBM2t4SXUveFN0RktmVUJqcldCOVZM?=
 =?utf-8?B?aHpkZWtsOGt6c0VsL2lpUC92a2R0SVl3aFFjSEg5dzNTNkFqWmFOZTBRdTJE?=
 =?utf-8?B?MDJNWGlRN0RnZmk1S004dDlKZlZIMUtwT1pRQ2lleitEajg3N3lHeFZJQzJq?=
 =?utf-8?B?dDhlTWFEaXdMazZKR0NLeThCY083Q0llM1NDTE5zaU5jTUxKNE5TaStFOU1S?=
 =?utf-8?B?T0ZtVTlWOWkrdjVmWkVLUU9tNXR5Y3ZVeCtiS1NNdTZKcTJVeFhIU0VwYURX?=
 =?utf-8?B?Rjd6czE3akRrTG1vT2tra1JwdDJ2eDVIVCt3dUlDRVZuYm1vZ3RSeHY2bHph?=
 =?utf-8?B?bmpnMTVoNVNrdWlQNGtzSGltRW1lODBKVDRucGR4bzZVc2ZXejVWbnlRNi9l?=
 =?utf-8?B?L0ZTVFZ3WVdNd0RTU3h0QzZDbTVPYk10UUNpN0JDbmRUTTMycXR1c2dwT3JF?=
 =?utf-8?B?UTZveWVxa2NWc2Q2SnVRTUdqMUxWN1crY3ZHcC9uWXdTSEZsbVREQ3JTSHZF?=
 =?utf-8?B?bUhwWkFsN1IxQ1JsRTlmQkJtaXpETTJncmVYcGFQVjU5SUMvZ1g5VGFWK3Vs?=
 =?utf-8?B?RWJPakI3SnJtOEQ5eGp2SUJKVXhOY0NXajAyWkF3c2RZNWcwckh1eUx4aUN6?=
 =?utf-8?B?V3RzQ0J1UEt0dDlXK05taTdQR0VsWThmakpQSW1aZlhIVDZJRndGSTl2ZVhJ?=
 =?utf-8?B?UHRXbktpcURSWEtTcUZrd3dzZ0VoVlN6cEpqQSsvSXhRQy9WNUpiMXlpZ2lm?=
 =?utf-8?B?VXo5UEZGSExKNmtHN0IzR2hDZ1ozQkpXbE03TGlaSmdkeFNLWWVyVzBvNXJW?=
 =?utf-8?B?QWo5eEhIR3dhUVBLcWJNMVFsdVpFdlJ0M3V2ZmRLUjY4NGIwQ1NVR2J3TzZo?=
 =?utf-8?B?Vmk3cXA4eVhqdmhtL1BQRDJWVnMvZFM0ZlQySlFWQUdLcmtrRTNSbTNXRkVJ?=
 =?utf-8?B?RGhtVjRkQlVkVkN5bGllVER3UkpZLzBEQkRnajVVdmY4OStDVVpHOXVWd25U?=
 =?utf-8?B?MHEwdG9XY25VcFJET1FOYktWaENuaDNkcjN0cDN6R3hZOXc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MkJtMFlaWGRIY0wvTm5BRlZwN0FFVk1pTGdQNnp1cndwL1JYNjIrREpoR1Z1?=
 =?utf-8?B?ajJpWmZnSnhUN2oyMSticEVmV2VPRExmWDZ5VVprb3RMdGhtMi9VUlNpS3hx?=
 =?utf-8?B?M0NLaW55VGZmUzVpMkU0Q2d1WEt1N0kwL1MwTDEyS2VoWFVqdHhYMmFpVFYz?=
 =?utf-8?B?QWY1M0FFS3VDTThNK0pVVVJnWlhQbG5XREpFMWF1dm5jRktBdkl5SGZldFRa?=
 =?utf-8?B?N2F6aTZzSGtpU0pDOVdzWitkQURHekJXZmd3dFRZbHNobTVZS0FPVEJ3a2ti?=
 =?utf-8?B?YkFkNFN4VXZsTXF0TGk0M0dLOWRNREliLzJQcWMyL0RET3ZRSjhUNW5TNUl4?=
 =?utf-8?B?TmZuREthby9IbTE0aUlBcFdlMGh3SVQ0NjFsZkZZKy9SUE9JVGs2WEkvK2l2?=
 =?utf-8?B?elFXSjNwMTBrMUhCKzBhdnRyUVpBejBZMUNhNmRjT3JnTG9peUJseFhOd1d3?=
 =?utf-8?B?V0UxbjdLU2VDNzJnZlJZZXVqV1lLUFRZZlJWcDR2bVNLbUpKaEhkTUUxdUpU?=
 =?utf-8?B?N21NemNLMXV3bXVzODVPS1BnWGNKaElWYmVyYUovQUVmUTdyenNPbzgxalQ0?=
 =?utf-8?B?NHlReVhvOXF2Wk5HOFdRNS9uc2JaQmNkSmw2elRiT2FORXRJY2JMSjJXWThk?=
 =?utf-8?B?eVVpS1Q3NnMyZVp2Q21Tcnc0YU1PdVFRbEpEUG1SUm5ISTUwNDBVd3o5VGtH?=
 =?utf-8?B?dGMzdzJqVW92eVh2aDczTFdKN1dUcWNTaFVNTndyaC9qQzl2b2ExRWNRM2po?=
 =?utf-8?B?Zzk4V2pXSXhrQnBRS3ljRTNYSm4vaUM5SmZ6OXpsTjlDQ1lhZk5FKzR5Y3VD?=
 =?utf-8?B?aTBCMTVWbEE5MkhmSXVXczJPRG5iU3ZYMkFyc29OTnlZMmtwazFLdVdaaFht?=
 =?utf-8?B?THBVRXhROTQrMFpvV2hsSUllMEt3aHYrK05MWVN5NkxYcWxxNEtKR0VuN08v?=
 =?utf-8?B?N0pwSnF0anc3Q0d0TjM3MGxuRWxwV21jVlZxZEUxQ3hLYnNpakxSTmRQNDU4?=
 =?utf-8?B?cktEaWhCNXdEcEEzcWJpQWdSQUNDbXQwakxFQ01ENmRnQ200YncwN3ZSN1Br?=
 =?utf-8?B?M1E5bFZkQ21HK1JtalRpNitJY25QUFhIL1JzVW1KTlIzYTJOMmozRTNmSTNQ?=
 =?utf-8?B?ZXJOSUZuV0craldha1FyME1nNDZUYVBmSS9DKzJ0Rm13b0d6WU9NaklLeElB?=
 =?utf-8?B?OFlNTzFrMS9YMzU5M1h1Tml6OHM1U1hrTjVsWER0N21qMitFeFR5czZCWXpw?=
 =?utf-8?B?dkpQY2U5a09QT20yUmF3c1dTOGNNaGk5MUZnSnovZFVJOXI4Rng1YVR6QmxL?=
 =?utf-8?B?YVp3ejltR0JJZmovYlFPT2l5cGJwc1dZWjEzaGl0TERtTThrUDB4NmFZa2VM?=
 =?utf-8?B?a0s5NC9rcGUreXNBUm1XNzR4ejhDM09kVlJMMW9tdDVLQmpaZkJmWkNKanZU?=
 =?utf-8?B?V0pEMEJzZzJpQzdUK2traEdCbkY2N01WZExXOWhpOWxDRFpwbWFDaEdwS1lK?=
 =?utf-8?B?Z2ZibjlFdmpTVkpxWnZaYVVPSXlsWncvTXNiYm5kbnY5NE5YejlmYjh6RUVK?=
 =?utf-8?B?aFRJV3RNWXl4OGwvaUdBckM4czRwUjlkMU1IYjlJSFliemM3OUYxRG94ZTN2?=
 =?utf-8?B?clBWNUdlRG44MUpEMW1oWUQ0aG9Mc3hNdlhSa0U5WEdGbmVyYjJuUlVjTXh6?=
 =?utf-8?B?VGVXdnJ0OTgxUko3U3dXU2ZHL2xVdXVDOUZ2UEczTVRKMFN1MkdoSktRc0tC?=
 =?utf-8?B?VWk4NkUvNFFxRVlTeWZSenJRaGM3V3MyMXFCdGZkY0JtNTVPZWZMZWtWVTJj?=
 =?utf-8?B?Y2FsM0syaitGRUNhOHlFUHhTVDQzUGpFTmJnaE8yR1R4NXhHM3pmNEtaSTd0?=
 =?utf-8?B?dEw4L2ErZnlaOFM4MHVJNC9wRmdsT1U4ZlE2dlJJZkhqc1ROSU55TWJUb2JB?=
 =?utf-8?B?dVJDTjFweDQvbllBaENKS0VKV0pkS25Rd1dBS29UbHdUekE0bTBDaUR6OXBM?=
 =?utf-8?B?QlUrZTlQQ3FmQVI2eTBqMHRMb1BwNWhyUC9zekJnKzZ6S2Z2WTVzTmYxYi96?=
 =?utf-8?B?TDI1b254VkJIYzZsa2JIMm8wYzR0YWtsMmN5Q3ExVm9ESm4rNC9HMUxRK0NQ?=
 =?utf-8?Q?JYjIvfK4WcpGOYL++plOzF2+e?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <034E2B72A6CCE1459607B2FF64D33506@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f29f07e6-c1b2-4d20-a42f-08dd15d86355
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2024 09:28:47.9667
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QcAFiBDescuL1P5dKBdDQbdKZjp76fjaPkFWhxYTL8EmNOYb5shPxOrGaYs2tL4ral13Gfuj+s9WZnGfiD6i9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB7668

SGksIEphc29uOg0KDQpPbiBXZWQsIDIwMjQtMTEtMjAgYXQgMDA6MzYgKzA4MDAsIEphc29uLUpI
LkxpbiB3cm90ZToNCj4gbXRrX2NydGNfZmluaXNoX3BhZ2VfZmxpcCgpIGlzIHVzZWQgdG8gbm90
aWZ5IHVzZXJzcGFjZSB0aGF0IGENCj4gcGFnZSBmbGlwIGhhcyBiZWVuIGNvbXBsZXRlZCwgYWxs
b3dpbmcgdXNlcnNwYWNlIHRvIGZyZWUgdGhlIGZyYW1lDQo+IGJ1ZmZlciBvZiB0aGUgbGFzdCBm
cmFtZSBhbmQgY29tbWl0IHRoZSBuZXh0IGZyYW1lLg0KPiANCj4gSW4gTWVkaWFUZWsncyBoYXJk
d2FyZSBkZXNpZ24gZm9yIGNvbmZpZ3VyaW5nIGRpc3BsYXkgaGFyZHdhcmUgYnkgdXNpbmcNCj4g
R0NFLCBgRFJNX0VWRU5UX0ZMSVBfQ09NUExFVEVgIHNob3VsZCBiZSBub3RpZmllZCB0byB1c2Vy
c3BhY2UgYWZ0ZXINCj4gR0NFIGhhcyBmaW5pc2hlZCBjb25maWd1cmluZyBhbGwgZGlzcGxheSBo
YXJkd2FyZSBzZXR0aW5ncyBmb3IgZWFjaA0KPiBhdG9taWNfY29tbWl0KCkuDQo+IA0KPiBDdXJy
ZW50bHksIG10a19jcnRjX2ZpbmlzaF9wYWdlX2ZsaXAoKSBjYW5ub3QgZ3VhcmFudGVlIHRoYXQg
R0NFIGhhcw0KPiBjb25maWd1cmVkIGFsbCB0aGUgZGlzcGxheSBoYXJkd2FyZSBzZXR0aW5ncyBv
ZiB0aGUgbGFzdCBmcmFtZS4NCj4gVGhlcmVmb3JlLCB0byBpbmNyZWFzZSB0aGUgYWNjdXJhY3kg
b2YgdGhlIHRpbWluZyBmb3Igbm90aWZ5aW5nDQo+IGBEUk1fRVZFTlRfRkxJUF9DT01QTEVURWAg
dG8gdXNlcnNwYWNlLCBtdGtfY3J0Y19maW5pc2hfcGFnZV9mbGlwKCkNCj4gc2hvdWxkIGJlIG1v
dmVkIHRvIGRkcF9jbWRxX2NiKCkuDQo+IA0KPiBGaXhlczogN2Y4MmQ5YzQzODc5ICgiZHJtL21l
ZGlhdGVrOiBDbGVhciBwZW5kaW5nIGZsYWcgd2hlbiBjbWRxIHBhY2tldCBpcyBkb25lIikNCj4g
U2lnbmVkLW9mZi1ieTogSmFzb24tSkguTGluIDxqYXNvbi1qaC5saW5AbWVkaWF0ZWsuY29tPg0K
PiAtLS0NCj4gIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfY3J0Yy5jIHwgMjcgKysrKysr
KysrKysrKysrKystLS0tLS0tLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMTcgaW5zZXJ0aW9ucygr
KSwgMTAgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL21l
ZGlhdGVrL210a19jcnRjLmMgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2NydGMuYw0K
PiBpbmRleCBlYjBlMTIzM2FkMDQuLjBkNTc4NjNjMDc1YSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVy
cy9ncHUvZHJtL21lZGlhdGVrL210a19jcnRjLmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL21l
ZGlhdGVrL210a19jcnRjLmMNCj4gQEAgLTEwOSwxNSArMTA5LDE5IEBAIHN0YXRpYyB2b2lkIG10
a19jcnRjX2ZpbmlzaF9wYWdlX2ZsaXAoc3RydWN0IG10a19jcnRjICptdGtfY3J0YykNCj4gIHN0
YXRpYyB2b2lkIG10a19kcm1fZmluaXNoX3BhZ2VfZmxpcChzdHJ1Y3QgbXRrX2NydGMgKm10a19j
cnRjKQ0KPiAgew0KPiAgCXVuc2lnbmVkIGxvbmcgZmxhZ3M7DQo+ICsJc3RydWN0IGRybV9jcnRj
ICpjcnRjID0gJm10a19jcnRjLT5iYXNlOw0KPiArCXN0cnVjdCBtdGtfZHJtX3ByaXZhdGUgKnBy
aXYgPSBjcnRjLT5kZXYtPmRldl9wcml2YXRlOw0KPiAgDQo+ICAJZHJtX2NydGNfaGFuZGxlX3Zi
bGFuaygmbXRrX2NydGMtPmJhc2UpOw0KPiAgDQo+IC0Jc3Bpbl9sb2NrX2lycXNhdmUoJm10a19j
cnRjLT5jb25maWdfbG9jaywgZmxhZ3MpOw0KPiAtCWlmICghbXRrX2NydGMtPmNvbmZpZ191cGRh
dGluZyAmJiBtdGtfY3J0Yy0+cGVuZGluZ19uZWVkc192YmxhbmspIHsNCj4gLQkJbXRrX2NydGNf
ZmluaXNoX3BhZ2VfZmxpcChtdGtfY3J0Yyk7DQo+IC0JCW10a19jcnRjLT5wZW5kaW5nX25lZWRz
X3ZibGFuayA9IGZhbHNlOw0KPiArCWlmIChwcml2LT5kYXRhLT5zaGFkb3dfcmVnaXN0ZXIpIHsN
Cg0KaWYgKCFwcml2LT5kYXRhLT5zaGFkb3dfcmVnaXN0ZXIpDQoJcmV0dXJuOw0KDQpBbmQgdGhp
cyB3b3VsZCByZWR1Y2UgdGhlIGluZGVudC4NCg0KPiArCQlzcGluX2xvY2tfaXJxc2F2ZSgmbXRr
X2NydGMtPmNvbmZpZ19sb2NrLCBmbGFncyk7DQo+ICsJCWlmICghbXRrX2NydGMtPmNvbmZpZ191
cGRhdGluZyAmJiBtdGtfY3J0Yy0+cGVuZGluZ19uZWVkc192YmxhbmspIHsNCj4gKwkJCW10a19j
cnRjX2ZpbmlzaF9wYWdlX2ZsaXAobXRrX2NydGMpOw0KPiArCQkJbXRrX2NydGMtPnBlbmRpbmdf
bmVlZHNfdmJsYW5rID0gZmFsc2U7DQo+ICsJCX0NCj4gKwkJc3Bpbl91bmxvY2tfaXJxcmVzdG9y
ZSgmbXRrX2NydGMtPmNvbmZpZ19sb2NrLCBmbGFncyk7DQo+ICAJfQ0KPiAtCXNwaW5fdW5sb2Nr
X2lycXJlc3RvcmUoJm10a19jcnRjLT5jb25maWdfbG9jaywgZmxhZ3MpOw0KPiAgfQ0KPiAgDQo+
ICBzdGF0aWMgdm9pZCBtdGtfY3J0Y19kZXN0cm95KHN0cnVjdCBkcm1fY3J0YyAqY3J0YykNCj4g
QEAgLTI4NCwxMCArMjg4LDggQEAgc3RhdGljIHZvaWQgZGRwX2NtZHFfY2Ioc3RydWN0IG1ib3hf
Y2xpZW50ICpjbCwgdm9pZCAqbXNzZykNCj4gIAlzdGF0ZSA9IHRvX210a19jcnRjX3N0YXRlKG10
a19jcnRjLT5iYXNlLnN0YXRlKTsNCj4gIA0KPiAgCXNwaW5fbG9ja19pcnFzYXZlKCZtdGtfY3J0
Yy0+Y29uZmlnX2xvY2ssIGZsYWdzKTsNCj4gLQlpZiAobXRrX2NydGMtPmNvbmZpZ191cGRhdGlu
Zykgew0KPiAtCQlzcGluX3VubG9ja19pcnFyZXN0b3JlKCZtdGtfY3J0Yy0+Y29uZmlnX2xvY2ss
IGZsYWdzKTsNCj4gKwlpZiAobXRrX2NydGMtPmNvbmZpZ191cGRhdGluZykNCj4gIAkJZ290byBk
ZHBfY21kcV9jYl9vdXQ7DQo+IC0JfQ0KPiAgDQo+ICAJc3RhdGUtPnBlbmRpbmdfY29uZmlnID0g
ZmFsc2U7DQo+ICANCj4gQEAgLTMxNSwxMCArMzE3LDE1IEBAIHN0YXRpYyB2b2lkIGRkcF9jbWRx
X2NiKHN0cnVjdCBtYm94X2NsaWVudCAqY2wsIHZvaWQgKm1zc2cpDQo+ICAJCW10a19jcnRjLT5w
ZW5kaW5nX2FzeW5jX3BsYW5lcyA9IGZhbHNlOw0KPiAgCX0NCj4gIA0KPiAtCXNwaW5fdW5sb2Nr
X2lycXJlc3RvcmUoJm10a19jcnRjLT5jb25maWdfbG9jaywgZmxhZ3MpOw0KPiAtDQo+ICBkZHBf
Y21kcV9jYl9vdXQ6DQo+ICANCj4gKwlpZiAobXRrX2NydGMtPnBlbmRpbmdfbmVlZHNfdmJsYW5r
KSB7DQo+ICsJCW10a19jcnRjX2ZpbmlzaF9wYWdlX2ZsaXAobXRrX2NydGMpOw0KPiArCQltdGtf
Y3J0Yy0+cGVuZGluZ19uZWVkc192YmxhbmsgPSBmYWxzZTsNCg0KSW4gbXRrX2NydGNfdXBkYXRl
X2NvbmZpZygpLCBhZnRlciBtYm94X2NsaWVudF90eGRvbmUoKSBhbmQgYmVmb3JlIG10a19jcnRj
LT5jb25maWdfdXBkYXRpbmcgPSBmYWxzZTsNCmNtZHEgbWF5IGhhdmUgZmluaXNoIHRoZSBjb21t
YW5kIGFuZCBjYWxsYmFjayBkZHBfY21kcV9jYigpLg0KQmVjYXVzZSBtdGtfY3J0Yy0+Y29uZmln
X3VwZGF0aW5nIGlzIHRydWUsIHNvIHRoaXMgcGFnZSBmbGlwIHdvdWxkIGJlIHNraXBwZWQuDQpC
dXQgaWYgdGhlcmUgaXMgbm8gbmV4dCBtdGtfY3J0Y191cGRhdGVfY29uZmlnKCkgZXhpc3QsIHRo
aXMgcGFnZSBmbGlwIHdvdWxkIG5ldmVyIGhhcHBlbi4NClRoaXMgbWF5IGNhdXNlIHNvbWUgZGVh
ZGxvY2suDQoNClJlZ2FyZHMsDQpDSw0KDQo+ICsJfQ0KPiArDQo+ICsJc3Bpbl91bmxvY2tfaXJx
cmVzdG9yZSgmbXRrX2NydGMtPmNvbmZpZ19sb2NrLCBmbGFncyk7DQo+ICsNCj4gIAltdGtfY3J0
Yy0+Y21kcV92YmxhbmtfY250ID0gMDsNCj4gIAl3YWtlX3VwKCZtdGtfY3J0Yy0+Y2JfYmxvY2tp
bmdfcXVldWUpOw0KPiAgfQ0KDQo=

