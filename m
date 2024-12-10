Return-Path: <linux-kernel+bounces-438696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A1D59EA47B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 02:46:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 328631888A16
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 01:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56FF14120B;
	Tue, 10 Dec 2024 01:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="TItrKjvs";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="suF1ytGd"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F1528E37
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 01:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733795159; cv=fail; b=tClaKgceUBN4EI9T3FMN+JEBG+F76srMv3CAv53AgZ6LgaNR6ptIkxA/5x1WukqhBpeaZCyVZjV4ffgOebtORpGuxaYHSKMxcnUDG0m5dptdsdeOimaP9c7LOdgPhCsy0tbQr9apQM76fRVPczLZB+fZ3V5ZN57cO0w1LKk/3ek=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733795159; c=relaxed/simple;
	bh=mL/LASKkpyBu1A8h8+ZVXC/5+gYb2qRqD23qce0uLMQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Yh7HyjVA6Wj2JIvoQqLXUJfg6EfBfrkkHbvuaDAh3zPyz5Dd4DLyByBTSr5S9JKfZjl8SS+MXsls45+n2UPv3olmkJHjgfdwWKC3caXlIMuHnZtAavd+fwwmSk14wWkypxHEdrTPTKbJSFFtf5Nq965THTX4naXMg4gGxub6HPs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=TItrKjvs; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=suF1ytGd; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 7be1b8c2b69811efbd192953cf12861f-20241210
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=mL/LASKkpyBu1A8h8+ZVXC/5+gYb2qRqD23qce0uLMQ=;
	b=TItrKjvs/4Q3Ga+QH5t1tgwcB6cO8GH+0Ri2YyXcR2xG0JUxmmnQIwBDnLOOGE4+UsHETlvExkOd04FtGCIvSy8XD3uOJzK8U9X/Ll355dIYVsClxdvxU4n0csSUsvv17ndLpyDYQJCFO3+GNGgNSgHcIsiM8cO8O76jvF8/sws=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:70d7fced-b016-482a-92e5-c2782b9305a3,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6493067,CLOUDID:6817b33b-e809-4df3-83cd-88f012b9e9ba,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0,EDM
	:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0
	,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 7be1b8c2b69811efbd192953cf12861f-20241210
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
	(envelope-from <jason-jh.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1132103712; Tue, 10 Dec 2024 09:45:50 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 10 Dec 2024 09:45:48 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 10 Dec 2024 09:45:48 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p0oakVinP16QiyHkBMv3+NfTfPrxOMD3GQ3QobOFoovTbMTsKWDmii/QNwJ6k8aH7/RE4EnbyauVCw+BhvfREHuLdicD787qE5FOq5RjbPqmhe9JEQxmzh+CGsaZB5FPA2dsjsD92tfRrPf9cmOgbayeStVQ/GlOHRV6wxJPMFtJcdisNYQTFWa392bfjUdtqNNmkpGVsToXTMEJfYJl9kEP6EWvGglLsSbtAQfTPeZiMFd+z8CsrMKSXpF9davTYJllaYIyxC6n4NruoDdG0UjKBIb0OI2kI3lJshRbLDK/NN0XMWq3FVlPChaPXQWgT0gaJ+WYvDVggd2vjZJ8aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mL/LASKkpyBu1A8h8+ZVXC/5+gYb2qRqD23qce0uLMQ=;
 b=XwqfqOEQC3TzXNpoAlGB6YX0+GLNd+XlDpxzoikioqumJWzpd7O5lBWEO81OlR4HNtYuI6ZgRl+McEPqry9yZTJJqN5Oi/7e2QUK4VYQOarFqrOsr+IciwsC2KJGF0i0WlVo3I+eYSSXAB1NWK0E9R0iTcOSs2UlUMABgqeoinWezZ1dBdBOOyzjaN+hPdLA9HiK5HcoTn3sX1E026Wz+g6NThDEa8dfWiRMm4yYATCFkj9jhxgjNbMK5YIs0ycHwW71PtptiLEzgY1kF9bBqeYwMe2eZeksIESYBFEr9nh7Y7i/pQvc8/XO4RpxVd94NLB9DD6ZTdOlLbeP1JVyXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mL/LASKkpyBu1A8h8+ZVXC/5+gYb2qRqD23qce0uLMQ=;
 b=suF1ytGdH6wtviSXKiDpl9XnhEF7lIlRVlcXLaGdplPTWo8JAfsXOGgy1nBGucd0w6uLo2Hd4SkF8UMQ8AzT/omj/NKjzkSm4RBAzygS4lIYcy3lx/PmaNeE0dp1pOWeWtcgax25n4sm0CF/6ARhyW2fR8BcfoIuy2LLgyERl4A=
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com (2603:1096:101:149::11)
 by TYUPR03MB7229.apcprd03.prod.outlook.com (2603:1096:400:358::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Tue, 10 Dec
 2024 01:45:46 +0000
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::c6cc:cbf7:59cf:62b6]) by SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::c6cc:cbf7:59cf:62b6%5]) with mapi id 15.20.8230.016; Tue, 10 Dec 2024
 01:45:45 +0000
From: =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= <Jason-JH.Lin@mediatek.com>
To: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>,
	"chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	=?utf-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= <Singo.Chang@mediatek.com>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	=?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= <Shawn.Sung@mediatek.com>,
	=?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	Project_Global_Chrome_Upstream_Group
	<Project_Global_Chrome_Upstream_Group@mediatek.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "fshao@chromium.org"
	<fshao@chromium.org>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v2] drm/mediatek: Move mtk_crtc_finish_page_flip() to
 ddp_cmdq_cb()
Thread-Topic: [PATCH v2] drm/mediatek: Move mtk_crtc_finish_page_flip() to
 ddp_cmdq_cb()
Thread-Index: AQHbOqFLDci7j75ntEyLCsET6X/UCbLZDT2AgAXH7oA=
Date: Tue, 10 Dec 2024 01:45:45 +0000
Message-ID: <b7398d1fb0d5ee96acf3587c44379b3f639a9a38.camel@mediatek.com>
References: <20241119163658.31405-1-jason-jh.lin@mediatek.com>
	 <c0092a07a9e6d0bc9b2dc85f379e6cddfa095ef7.camel@mediatek.com>
In-Reply-To: <c0092a07a9e6d0bc9b2dc85f379e6cddfa095ef7.camel@mediatek.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR03MB7682:EE_|TYUPR03MB7229:EE_
x-ms-office365-filtering-correlation-id: c9a94dbd-dd4f-4992-87a2-08dd18bc5d8e
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?ZVRta204bmpzZk5vOThxUFZ3a3dTZk1nM004YVo4WVREeHltL04vRmxWTUo5?=
 =?utf-8?B?R0JPMTNxY01Cd0pvK3pnT05WaUZVTXpQcU9TdHpzayt0d0JpYnRrRVNFRlhD?=
 =?utf-8?B?WkhxeXJDbklZTXJLM1JNdVNkZVJ6SElhSVM0cFk4a3VRUktOdS8vSnRJRXFn?=
 =?utf-8?B?bXRIcEtZSHpianErRWVyU3RwOW0rY21OeHlKTXR6M3FoZEFKS3RFQ2dzcFNW?=
 =?utf-8?B?Mm9aUFI2V3dwLytuZUpsK2FzbjBoUXNxU21HaEl6dGdERTJFREdsc29rVDRa?=
 =?utf-8?B?eDNueWtJSzUyTTZtbFNhQ0t4L3FKb1h3cVpqbXJaMFdOYjRGVmJ4N3VLQlg4?=
 =?utf-8?B?bkdYQVMrcWRUL3RKSEFjTWtPaDFDLzB3Z2xSMjNTeGltQ0ZRaERzbEpNUmhp?=
 =?utf-8?B?Y1liZ3FhWEsyYXd6T0d2WDNlalpsNSt4V000bStYemtSL2dOWE9UN2lpTVZx?=
 =?utf-8?B?NXMxRnRJc29YdjNUeVVvSkNrVitjb2VJQzZheUJVNGVyODQyQlppRHZNYTFL?=
 =?utf-8?B?cy8zWGlQY3pTejh4WDZrN1RER05DdXFrc3pGSEpRY1M3TXZZTlNlSCtmUVBu?=
 =?utf-8?B?NlltajFqaGphcFozMTIvYVhVU3V5TldyNXlsV2NORGhOUDI1eEQ5eHRBYVlN?=
 =?utf-8?B?aDgvekdERW81S2t4ZWZjdTlTSk43NmlGM0l3V2xqaGFlSWNHME5Dd1BYRnZP?=
 =?utf-8?B?YXo0T0ZteWdKMGZ2L0hTZysxTmJma0ZaNExEcUNqMlhpR1ExNTZsb0N0b0hk?=
 =?utf-8?B?U1k4K0dBdkJjdVRRbmMvZW5xWFc0ZUNJbHNtK2JWNWlSeWNSbDNHbVVTOUxx?=
 =?utf-8?B?d3Z4a1hMbTF3Z3FSTmlJRjIrSE5OZ2RXMXR6bjBRQ2tibjRLU3c3SjRDVVNI?=
 =?utf-8?B?aDFWK1Awb2dYWkVmeElEbnZVSk9RMGRiK3VMYUZDL2RFeStia2J2Z09MTWZp?=
 =?utf-8?B?emx0TExMVjIvVWpNVmhLbWxQenluYlFLWVJjWFJ2TGpFYnU2bm9ibjJRQWlE?=
 =?utf-8?B?ZlVCdmdQS3BvdEF3ZTh5ZHhQS05rNGUwYXZ6VEVId05QcFBvVWk4amljMVM2?=
 =?utf-8?B?TmFkeDFERTEvbGlaUGtmKy80WVFva0pyZjh4QXB3dWNHOHdmNWRtL3hxWCtt?=
 =?utf-8?B?dlh6ZlRFNUpJSnlUMk1XZys0Sjg3RFh1Mjh4bytSaHcwRFg0akJBclJHNzh6?=
 =?utf-8?B?MDI1U0huV0ZpbkQ2K0hsQ1ltbVZzWXQ4V1d5ZTU5REJHSUlTSVRSbFVEMVNF?=
 =?utf-8?B?NVZFMXZ5dEYyKzVpWEtQVUpSekpZcFY1eTFSL2N4blJuRWpMQXZiNUN2QnFO?=
 =?utf-8?B?bHIyaUIxWkdYV3ZEREF0RDJHK1RTc1ZNK2ppdkp2RHZDdjk5aExza2IvYUJt?=
 =?utf-8?B?Zk42K25oR0FSakVYQ0tMV0ZCZlhiOU5USEpMQTQ4MnY2Qk44dk1jbzY5SXBC?=
 =?utf-8?B?RElDWlNyNlBnQW51OWZFeVRxRzE3c2t6TEVBbmJKNXZYTXNNbjVsek5uRENS?=
 =?utf-8?B?MHJzQWxQY3gvR2RQS3gzTXU3d0lBRmhONTIyZkNvTlcvSkpFcjdOQjhQa28z?=
 =?utf-8?B?Y1lUSE9FRUpkdUZudFFnUCtGYXp3M01jRzBXY0ZnOWxMcWdvNW5xaEZVMG5H?=
 =?utf-8?B?OThJWVIrRjY2OUpBMXJzZkU4QnF6Mm5PWFlHbi9jb3Y1VERONW04d0dYOTdu?=
 =?utf-8?B?U2N6TkxwL1JiQ2plTjhQMk1GVXIvN2VucytDMkcyMUxKbFBJWkJtZlhOMWpu?=
 =?utf-8?B?RWwyY2J5OTYzUC9LWTI5SUhGU0RFUjgzNURrK3pRWVlvZ0JITEtscUZhemtx?=
 =?utf-8?B?RTZZWkpqVnlSNWFZNVhCNnhiNTNUQ0RXeThCSWRFQUNmSjhxTDB3TExmUGwy?=
 =?utf-8?B?ZlRKZGthamt0ejJCejJtVzVtOFN3Mm5XSFRFb2JvVXNsb0E9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR03MB7682.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OW90dWt2Vm9TL2RqLzI4cjZhb1BFYmtmc01TUkNoYldkNmVjSGEzSG9VM2NN?=
 =?utf-8?B?OUFkdDJTejF3VFhYNTdGb1U1VnFCZlhBOGhLaXBERjVmakVBaHVESnVpZkVN?=
 =?utf-8?B?dXMrRmJ4QUtYcGV4dXBLazVlbS9OK010SllvazJWM3ZYT3NHaUs4QXR2a0JS?=
 =?utf-8?B?cG95NVUvdFZKMXo1b1VjQlQ3MnRTaks0VE1iY21oUEdFSWlQSkxGTUE4VzBk?=
 =?utf-8?B?cmRHZm8weE43YVk1VHZaMWxCRmJNVDF6RWc1QnR6MDFKQ05GcUthNnNCRDhl?=
 =?utf-8?B?TmE1c0EvWVBCMk8wazR6aHUyb0hKMk5SMU9kMEg0SXRaNm1GaHpmVGhqR0xH?=
 =?utf-8?B?VWVwUXJEUlpGYWpwOGlSMExBTmRXblNGUnpaZkxzcTZ3aVJ3UUdDa2lwS0RP?=
 =?utf-8?B?MldQTHNTQXlVSFdMNGxzdE5OYUZqYVhoTzdHZnVMZkp3ZXZHWHRUSW5oWll2?=
 =?utf-8?B?RmdwY1l1dWdHWTUxelh4TElDZWJMbHdLRWdiaGNKMjJITnZCcG1TQjF5YUx3?=
 =?utf-8?B?S2l1MUlRcEQ4S2cvNHdjRERVUVI5ZlFSSll2NWlwV2xMeW81OWJLN28xRkZk?=
 =?utf-8?B?VFdoQ05lWFlYaFgyTllha2d0VDI1TGRDb0syeENNSWRwVmRMcHlpSjlCQlNL?=
 =?utf-8?B?TXRVaURQaVFrQjFEcDFneWhleDhiT1MxWDMvelRDVUE1alhob0VZSEdoSWVX?=
 =?utf-8?B?Z2pRVzJBbnhXNDBWbmcxUGNaOFJMVmNONzE2NTNoaVR3c0MzeXd5dnREMGVo?=
 =?utf-8?B?QzZxaVVWT2FYcXIrK2FOVkxZT0NsdE81VUhmRkpPR3BLOExpRGNnY2pkY0ta?=
 =?utf-8?B?dm51ZHBBL3VjSUV6ZC8wL2ZoVXVMdW9EMENaSXdUcmxTN09aNVdhdFhIbklo?=
 =?utf-8?B?SVZsZXp1NXFGVmwwS1Z6QkZSL2VtODRCYjkyeVRsOHhNa09IV2h2M3Z6Q3Q3?=
 =?utf-8?B?eVJIODlXaEZxelIrSWMyaEtEcTFlbzhKZTV2K0lrSHpseHVuVkxsZWlyTTdp?=
 =?utf-8?B?M1ppMGVpZmJDQ0kzYTkrazN3dUFBRVdBYWF6OFJHcVhqYkJPQ0dzSDhsT3M3?=
 =?utf-8?B?OGJ2QzM2T3VXeXBQZVR2blAzRjZGWElJVDIvY2t3OENGb0l1ZC9SSFY2TFdJ?=
 =?utf-8?B?R2F0Yjc3eGQzZGU5cDBsQXNOMzdkeUx3eXdRUk9BM0hBYSttRzN2ckNURkZS?=
 =?utf-8?B?cnkyU1h1RkhYZHNvVC82L3RCQ3F0RXpVMkk2eEszeXJYeko0RnkzaTFINnVu?=
 =?utf-8?B?TDRxOEdXQVF0dEptL2ZpbGJQMk44Q0JRQitGZmExWWkxdDBCVDVJTEF0Zys2?=
 =?utf-8?B?czVYQ2lPbUlaUGNKWVZBSHo3Q0JtazNoa3pRNXF6NGxOYXlDcTJWQ1JPVnJU?=
 =?utf-8?B?Qmk4a0s1MlNQbUMvWHJxeHJXNUVYSjZOeVhIRG43bGhYZGhPK1FHL2w5NFFM?=
 =?utf-8?B?Ym1YZTVKbEhCMmE0b28zS0JPdmQyUkU4TEFlUkVkZHEvWDNaNWZMRUtQVmRD?=
 =?utf-8?B?czJMZVRkVmxzWGRDSTJDcWkzeHlqK2M5TkE5Sy9xM1BqVlEwcHV0eTFnNC85?=
 =?utf-8?B?SUF0OFdkVFd6cW9sNlpWZk80Umx4RFF4eDAzQTlsY0p5Q3VTQWlBOWhXbHl3?=
 =?utf-8?B?Qi90UmRGZ1M1UFk0RU1iYnQ3eHFGQ2J5dDJDRFVRNHVQUTNFUUpNcXBsRWpG?=
 =?utf-8?B?R1RZSkhnZW9nWW9qVFlRZjVWOXJDRWFhUlpNRTlpK20yWXh6NDdUWXNleXhH?=
 =?utf-8?B?TDFwR3RnTWlDUHV6L2J2bkw5SHkzRkVjYUFEMXpsVnZuZ1REYWRObFM0SGJt?=
 =?utf-8?B?Sm1PUlFWdHIzaUtjNkNGcGJkZUgyTEM1MExnVXJyT0lkdzBuODBSTjRzSHlM?=
 =?utf-8?B?OVg5RzgvMzZCTnZKVXdQUm9hOUZBSk9iemJUR2JpNWpvYW1jK2pacGdFOFFo?=
 =?utf-8?B?NkorNi9OSzJUaUFVRmthd3haYzd2SGFKSTJhcEhwUGhCOURXNjhyanM4MGlt?=
 =?utf-8?B?RGRjVE5iS205WTJyV2Fha1V0SWRCSHlIZmZNTTd6TDk0dVdaVGppKzJRME05?=
 =?utf-8?B?KzdKNnp2QlJLNkUzNVd2cjR5ZXNyZEs1WnBWTU1tNXNqVFVoRDVKK29SYWtR?=
 =?utf-8?B?TFpndnhtRWhQc3BHeU1YZTNzb2ZnZG5NdXhoZnFWV0VnZ1hHTk1Zb1VLbHJP?=
 =?utf-8?B?VUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CBC916D8C6E2444FA8769E8539805935@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB7682.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9a94dbd-dd4f-4992-87a2-08dd18bc5d8e
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2024 01:45:45.8677
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NnXfCYGznxHUGX+zZi3bduqOLgsAjVnUAOOL1kaNdBV0lM51hHtLP1ujDf6fBZh+T6iidqlGOV/oXWu2G8pZxn0fPsZCo5xWX18gDMsi4IQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYUPR03MB7229

SGkgQ0ssDQoNClRoYW5rcyBmb3IgdGhlIHJldmlldy4NCg0KW3NuaXBdDQoNCj4gPiAgc3RhdGlj
IHZvaWQgbXRrX2RybV9maW5pc2hfcGFnZV9mbGlwKHN0cnVjdCBtdGtfY3J0YyAqbXRrX2NydGMp
DQo+ID4gIHsNCj4gPiAgCXVuc2lnbmVkIGxvbmcgZmxhZ3M7DQo+ID4gKwlzdHJ1Y3QgZHJtX2Ny
dGMgKmNydGMgPSAmbXRrX2NydGMtPmJhc2U7DQo+ID4gKwlzdHJ1Y3QgbXRrX2RybV9wcml2YXRl
ICpwcml2ID0gY3J0Yy0+ZGV2LT5kZXZfcHJpdmF0ZTsNCj4gPiAgDQo+ID4gIAlkcm1fY3J0Y19o
YW5kbGVfdmJsYW5rKCZtdGtfY3J0Yy0+YmFzZSk7DQo+ID4gIA0KPiA+IC0Jc3Bpbl9sb2NrX2ly
cXNhdmUoJm10a19jcnRjLT5jb25maWdfbG9jaywgZmxhZ3MpOw0KPiA+IC0JaWYgKCFtdGtfY3J0
Yy0+Y29uZmlnX3VwZGF0aW5nICYmIG10a19jcnRjLQ0KPiA+ID5wZW5kaW5nX25lZWRzX3ZibGFu
aykgew0KPiA+IC0JCW10a19jcnRjX2ZpbmlzaF9wYWdlX2ZsaXAobXRrX2NydGMpOw0KPiA+IC0J
CW10a19jcnRjLT5wZW5kaW5nX25lZWRzX3ZibGFuayA9IGZhbHNlOw0KPiA+ICsJaWYgKHByaXYt
PmRhdGEtPnNoYWRvd19yZWdpc3Rlcikgew0KPiANCj4gaWYgKCFwcml2LT5kYXRhLT5zaGFkb3df
cmVnaXN0ZXIpDQo+IAlyZXR1cm47DQo+IA0KPiBBbmQgdGhpcyB3b3VsZCByZWR1Y2UgdGhlIGlu
ZGVudC4NCj4gDQoNCk9LLCBJJ2xsIGFkanVzdCB0aGlzLg0KDQo+ID4gKwkJc3Bpbl9sb2NrX2ly
cXNhdmUoJm10a19jcnRjLT5jb25maWdfbG9jaywgZmxhZ3MpOw0KPiA+ICsJCWlmICghbXRrX2Ny
dGMtPmNvbmZpZ191cGRhdGluZyAmJiBtdGtfY3J0Yy0NCj4gPiA+cGVuZGluZ19uZWVkc192Ymxh
bmspIHsNCj4gPiArCQkJbXRrX2NydGNfZmluaXNoX3BhZ2VfZmxpcChtdGtfY3J0Yyk7DQo+ID4g
KwkJCW10a19jcnRjLT5wZW5kaW5nX25lZWRzX3ZibGFuayA9IGZhbHNlOw0KPiA+ICsJCX0NCj4g
PiArCQlzcGluX3VubG9ja19pcnFyZXN0b3JlKCZtdGtfY3J0Yy0+Y29uZmlnX2xvY2ssIGZsYWdz
KTsNCj4gPiAgCX0NCj4gPiAtCXNwaW5fdW5sb2NrX2lycXJlc3RvcmUoJm10a19jcnRjLT5jb25m
aWdfbG9jaywgZmxhZ3MpOw0KPiA+ICB9DQo+ID4gIA0KPiA+ICBzdGF0aWMgdm9pZCBtdGtfY3J0
Y19kZXN0cm95KHN0cnVjdCBkcm1fY3J0YyAqY3J0YykNCj4gPiBAQCAtMjg0LDEwICsyODgsOCBA
QCBzdGF0aWMgdm9pZCBkZHBfY21kcV9jYihzdHJ1Y3QgbWJveF9jbGllbnQNCj4gPiAqY2wsIHZv
aWQgKm1zc2cpDQo+ID4gIAlzdGF0ZSA9IHRvX210a19jcnRjX3N0YXRlKG10a19jcnRjLT5iYXNl
LnN0YXRlKTsNCj4gPiAgDQo+ID4gIAlzcGluX2xvY2tfaXJxc2F2ZSgmbXRrX2NydGMtPmNvbmZp
Z19sb2NrLCBmbGFncyk7DQo+ID4gLQlpZiAobXRrX2NydGMtPmNvbmZpZ191cGRhdGluZykgew0K
PiA+IC0JCXNwaW5fdW5sb2NrX2lycXJlc3RvcmUoJm10a19jcnRjLT5jb25maWdfbG9jaywgZmxh
Z3MpOw0KPiA+ICsJaWYgKG10a19jcnRjLT5jb25maWdfdXBkYXRpbmcpDQo+ID4gIAkJZ290byBk
ZHBfY21kcV9jYl9vdXQ7DQo+ID4gLQl9DQo+ID4gIA0KPiA+ICAJc3RhdGUtPnBlbmRpbmdfY29u
ZmlnID0gZmFsc2U7DQo+ID4gIA0KPiA+IEBAIC0zMTUsMTAgKzMxNywxNSBAQCBzdGF0aWMgdm9p
ZCBkZHBfY21kcV9jYihzdHJ1Y3QgbWJveF9jbGllbnQNCj4gPiAqY2wsIHZvaWQgKm1zc2cpDQo+
ID4gIAkJbXRrX2NydGMtPnBlbmRpbmdfYXN5bmNfcGxhbmVzID0gZmFsc2U7DQo+ID4gIAl9DQo+
ID4gIA0KPiA+IC0Jc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgmbXRrX2NydGMtPmNvbmZpZ19sb2Nr
LCBmbGFncyk7DQo+ID4gLQ0KPiA+ICBkZHBfY21kcV9jYl9vdXQ6DQo+ID4gIA0KPiA+ICsJaWYg
KG10a19jcnRjLT5wZW5kaW5nX25lZWRzX3ZibGFuaykgew0KPiA+ICsJCW10a19jcnRjX2Zpbmlz
aF9wYWdlX2ZsaXAobXRrX2NydGMpOw0KPiA+ICsJCW10a19jcnRjLT5wZW5kaW5nX25lZWRzX3Zi
bGFuayA9IGZhbHNlOw0KPiANCj4gSW4gbXRrX2NydGNfdXBkYXRlX2NvbmZpZygpLCBhZnRlciBt
Ym94X2NsaWVudF90eGRvbmUoKSBhbmQgYmVmb3JlDQo+IG10a19jcnRjLT5jb25maWdfdXBkYXRp
bmcgPSBmYWxzZTsNCj4gY21kcSBtYXkgaGF2ZSBmaW5pc2ggdGhlIGNvbW1hbmQgYW5kIGNhbGxi
YWNrIGRkcF9jbWRxX2NiKCkuDQo+IEJlY2F1c2UgbXRrX2NydGMtPmNvbmZpZ191cGRhdGluZyBp
cyB0cnVlLCBzbyB0aGlzIHBhZ2UgZmxpcCB3b3VsZCBiZQ0KPiBza2lwcGVkLg0KPiBCdXQgaWYg
dGhlcmUgaXMgbm8gbmV4dCBtdGtfY3J0Y191cGRhdGVfY29uZmlnKCkgZXhpc3QsIHRoaXMgcGFn
ZQ0KPiBmbGlwIHdvdWxkIG5ldmVyIGhhcHBlbi4NCj4gVGhpcyBtYXkgY2F1c2Ugc29tZSBkZWFk
bG9jay4NCj4gDQoNCk9LLCBJJ2xsIG1vdmUgdGhlIG10a19jcnRjLT5jb25maWdfdXBkYXRpbmcg
PSBmYWxzZTsgZWFybGllciB0aGFuIA0KbWJveF9jbGllbnRfdHhkb25lKCkgdG8gYXZvaWQgc2tp
cHBpbmcgdGhlIHBhZ2UgZmxpcC4NCg0KUmVnYXJkcywNCkphc29uLUpILkxpbg0KDQo+IFJlZ2Fy
ZHMsDQo+IENLDQo=

