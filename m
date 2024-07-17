Return-Path: <linux-kernel+bounces-254648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E77F59335C9
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 05:44:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15F061C22D8B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 03:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6771F6FC7;
	Wed, 17 Jul 2024 03:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="dAVzXph8";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="pe1pWNqn"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AB196FB9
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 03:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721187869; cv=fail; b=emQSBqkkvVCZ7OBZdIRf/JlxmXzixDAqkxon+/h6R0dYsnrNei3FBUfyfaGvfxiCBbIqLuCuaXb3JsmP+mY/0rK1fUw4tB8j5y8nVZr/w70L/0Fu2JubIceafuZ5e2h+ed1ie39Oz1fViJuUQiqFjyFjcu4FmU57oymj7Tb0egw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721187869; c=relaxed/simple;
	bh=UJx1N3qiZyQqM4FiWSf2jSSZ9d6HQb/t5tCV/Zk5MtY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=li4gu0Xw3RNZwfdyLV1o72vwGMP2HU1MEnh3yB1xcuyrxfmR3fGBtxEy/tjo8wq5jCLaTfcbrzEpk5IP0f5mA/sMALaQxT0lrrC18zkWPALMMVV/Ny1uT3zy+8GvCqlq3cB1XjOvpt1cWCb/yEJXHJg6WVgL8Wdquy2qcaZYPQY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=dAVzXph8; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=pe1pWNqn; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: d90f7e5c43ee11efb5b96b43b535fdb4-20240717
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=UJx1N3qiZyQqM4FiWSf2jSSZ9d6HQb/t5tCV/Zk5MtY=;
	b=dAVzXph8rFkIh/eb0w150CeH5FLQRVkK9F4FSBcMJkHER1aETJlJ0lQBsx5DVtXZbBWOdsyN1EzlWXnbqgoadKo8QTCKV4OdESsL/FrvWb3foV5AZL22My1/TKY0Jx9Er4pbSDSKX1ee0Bn9GbISBvTWDS8mA0HqNUqJthXPS6U=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.40,REQID:d0b2fbaa-cd80-431e-89d8-29821802d270,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:ba885a6,CLOUDID:e49c6345-a117-4f46-a956-71ffeac67bfa,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: d90f7e5c43ee11efb5b96b43b535fdb4-20240717
Received: from mtkmbs09n2.mediatek.inc [(172.21.101.94)] by mailgw01.mediatek.com
	(envelope-from <jason-jh.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1761310080; Wed, 17 Jul 2024 11:44:19 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS14N2.mediatek.inc (172.21.101.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 17 Jul 2024 11:44:18 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 17 Jul 2024 11:44:18 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vxoCVyF+MfixT2S9Zv9MvspZWHff2nKoPRExIUP4ui9JH9t6MDoUycOHAZmBXEm1gcBYM7iAGL+O855lmMAITZotC+tq036Ta+lPX57fHGA4z+5z7U4HAfg6DYTUzWvvfSUH2n7hs2xS+iJuRJGeV7dPlWatxIobe4VA2PaEZfBu+O2Y6v/JFiGRytikUY73PjqPg833aK0OR0g/rcAqC6DqJLUdBDKDSqbFs4ymwRS4aTDDweqSn80UF5vBDzNLJY3qHC38NHTjWvaM/G7/Tl5rsFcqSKwUoCH7Z3EuozfLgtRRY6VsGPyisNiPc2436NhSdS1cf4lFLn1CtsD+xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UJx1N3qiZyQqM4FiWSf2jSSZ9d6HQb/t5tCV/Zk5MtY=;
 b=lTUhmLPHtWXRoKKqt2DfFlvHxAJBSb+xTqdW3N9fwQqK2WH2zX2xMafFZv3Nzo2a83yd2DHoERnsFOA4iUJA0qUwTlPbI8PpZAi3fKR2Jrgup1gikCXwpGO3p5NpgUlBamiNIsSrzMF25cbwz9IeYyUsYE03jQv/XQrzK654k2j815LhI1JeJFn7UghLnZRisy9x6N+/7fQeGMU2yPqCAAN4FYWdf5CNPrD7jztxEOIRHVXMx0skaTcVrZwpGa9yOeRZjszpwIcnTUdofxa/cNqQEgZM4KkzFFqUkAnwakyyLM/VKX+VOwt8YVFfn+AYmluXXAe3m5zkR9LtJ/t/sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UJx1N3qiZyQqM4FiWSf2jSSZ9d6HQb/t5tCV/Zk5MtY=;
 b=pe1pWNqnwv6qdEIKahv1taPHQVLtmiBT9nOop8ZLJ1Ze7BT/Jm7yhfaW6vz1Kv4mg68WdGVFmqovN2c6/m/4BSybZYw3cEawyx2vJLZ81cgCn6sO7wliY/7SeZEg5bhLaH6Z1wJHPDuw6kzYE4F/MpnjOjP4cLuPCjRK8CyMJXI=
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com (2603:1096:101:149::11)
 by KL1PR03MB8217.apcprd03.prod.outlook.com (2603:1096:820:10b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16; Wed, 17 Jul
 2024 03:44:15 +0000
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::c6cc:cbf7:59cf:62b6]) by SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::c6cc:cbf7:59cf:62b6%5]) with mapi id 15.20.7784.016; Wed, 17 Jul 2024
 03:44:15 +0000
From: =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= <Jason-JH.Lin@mediatek.com>
To: "jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>,
	"angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>, "chunkuang.hu@kernel.org"
	<chunkuang.hu@kernel.org>
CC: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, =?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?=
	<Nancy.Lin@mediatek.com>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, =?utf-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?=
	<Singo.Chang@mediatek.com>, Project_Global_Chrome_Upstream_Group
	<Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: Re: [PATCH] mailbox: mtk-cmdq: Add unregister mailbox controller in
 cmdq_remove()
Thread-Topic: [PATCH] mailbox: mtk-cmdq: Add unregister mailbox controller in
 cmdq_remove()
Thread-Index: AQHavaNGmeIQnKWVzkKgT+U+XkKGsbHFzHUAgAAcj4CABvrcAIAAi42AgC0MewA=
Date: Wed, 17 Jul 2024 03:44:15 +0000
Message-ID: <470f96fc0dd48ad0ad6bedb235a2e510c808e3e7.camel@mediatek.com>
References: <20240613150626.25280-1-jason-jh.lin@mediatek.com>
	 <8ef254cb-ac65-405d-bcee-d0990536fb32@collabora.com>
	 <44f6308379a8b6c834df6ff0604c652bf1f7a4b7.camel@mediatek.com>
	 <47f1c2c79ad03094ebf411e13516cca47054c962.camel@mediatek.com>
	 <a681e496-4979-4f4a-9f79-9636d9496fa3@collabora.com>
In-Reply-To: <a681e496-4979-4f4a-9f79-9636d9496fa3@collabora.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR03MB7682:EE_|KL1PR03MB8217:EE_
x-ms-office365-filtering-correlation-id: 218d0ada-0981-4948-356f-08dca612bafe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?V0hLdDUydGlSYlFqdk9qdVkwMGJVT3ZKaU9EMUNLVTVKSURtZUpMUk51L1oy?=
 =?utf-8?B?TUM3N0s0alVWV0FPdTA1NHBrVzJCQkJudEhoMDA3QnBhWUx4WTNaeWVYUzB3?=
 =?utf-8?B?UEgzd3ZwZno5dnRvWWV6WkxjbnYvWFpnS05CWWNpaHVBcXpJcjY1bzJhcE40?=
 =?utf-8?B?SnFETU05UDg5VDltNnp1SXplZS9jYlJJZVNFbGFMOXlMRmRSc2Z0R29rQkJ1?=
 =?utf-8?B?R3diWGZrTlZ3WVZRZ3RDbmNWMy9hUndkbk82YzR5QjRieitaTVFSR0JjSG94?=
 =?utf-8?B?ZnBVcWc1U2pLb1d6M3lZSHpCUTRVNGZ3bG9hOHZWU2s1KzA0ZUFlSXFsRWhv?=
 =?utf-8?B?bmFqVWVlZklDMStzaHVaeVlWL3A2QlQvVCtpaDZpSXEvOWdia2J5SWc4bFJU?=
 =?utf-8?B?dmJ0YnhwZU5SbmZhOHRReTdWRXZCUHJJcW9LVkdpUkorOWtOL3Zad3pvbThp?=
 =?utf-8?B?Y2RuK1NHRm1QQmcyZk9WemhxaUlKTk9rVHRaT2JxOFNtNHRrSzcrNmFVN1Vx?=
 =?utf-8?B?OWRwaDFtRHdEeVJDbTFYSXk0K3dMZitZMjNCeEkvVFl3Zm00VmZMTUNuYUdT?=
 =?utf-8?B?Z3RnZERZNzY1WWQ1WHgzOEhsVkhpZlVDYnRSY3UweXFzTXU5UkNuMW1CNy9q?=
 =?utf-8?B?OStJY1BOaWcwbUs2QU9GYVRPZUpiaVlwUkVWT1g2OCtYTnhuM01xRk5PemN0?=
 =?utf-8?B?R0M5TlU5WGowWW5velZ6eWJzVUFFZ1RqdHB0NEdWTDlLMVRXNkhQMlB4dHBB?=
 =?utf-8?B?RlpsdFFKckwxMnZQRmltTi81R2VyRTQrRXR5MkJieTUrQ3ZLRnAxcnIzYmh4?=
 =?utf-8?B?WTBpSHRJSlRqUEdLT2Y5U1ZKeUJBYU05a3BDUGRFRDJvMWFDajVxTU5oc1Yw?=
 =?utf-8?B?TWUxUHRZVzZheGFFQXlXZ0swemZiRnRGR2NKdS9ZaXhQdzdlNmF1aHBvckRQ?=
 =?utf-8?B?OE5Gb2d2S0RZVCtyRmtTY2JHWXQ0TklRT1ZEMVQvai9rVlNJWit5SWIweG1B?=
 =?utf-8?B?YWloTmx3QkMwZkdwajE2S3dXb21QcU12T01iOTN1Y0lhRWs5MWxNR0NKbGVL?=
 =?utf-8?B?NHJaN0FHaTR5c0dHZmVzOUp2OG9FeWtaZTlFekFQWXYzTjYxY0dqWXdrYUpK?=
 =?utf-8?B?Syt4RnBveUVpdmlJbFN4ZVMrbVpWaW9RVE9MSTZES0swaGIrNEdzZTIvenp6?=
 =?utf-8?B?cGJqZEs0cGRhUUdwbTFwT1JqS1NDSHRMZTdyZmdFeS9xYVBLVytwRUZacVVu?=
 =?utf-8?B?NmQ0SnVPUHFKRE1UK01KWEZaRWVUbnJxTm1SNk5EVzhYU0wrMTNMUFRFbG4w?=
 =?utf-8?B?YnRUTW1pMXVRR0Z5VEh5Tzd6T1FsakxBa2pEc1F4WU5ZelNJM09EZzZFeTM3?=
 =?utf-8?B?SklhK1hGWWpaU1VxbERaanA5Z1pMaStTazhwUm9XVWp4c0xnaXc1cmNZOU0z?=
 =?utf-8?B?bDUzbzE1OGJJd3pzUnVZRTlicEo2b200aVZNZDJGRXU5dHVZUUVnNVZrQW5F?=
 =?utf-8?B?elI2b0FHY01YM2Y2Wlg1NU5LWUxSRmtZaGJHRVU3Vnl6eW9ia1J5YVNWYUpt?=
 =?utf-8?B?OHRiMUdoTzBoYlBMYnUydktKMHBBa3gxTVpiajE4endqSTUvakFES3orOENp?=
 =?utf-8?B?WXNScUorMkZvOW52V05QeUU0ck5mWkl6UU1MRXJBNEpyYmhqbkVid3FwZGFG?=
 =?utf-8?B?S05QdzZqOXYvdkg3cm9oUVNQQnIzV2FuU1VEN0J5TWkzQWcrbFJHVXZKK09J?=
 =?utf-8?B?VUJkWmNudGhxamNnWWQzWkdwdHl0SlJnU3RJN3Q2dXVQbm1ITzdld081SzVY?=
 =?utf-8?Q?oPIrfyKPbZG2SkRi7EMZxOLNk8jkEvyv+8r+U=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR03MB7682.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cUVoRGhMN0ZMVjVSSHRpbGdSeS9lNkduRmtBdlNRK0NlV2t2U0hMaWpaSzVD?=
 =?utf-8?B?YVk2anJ0blZaenVBbmJQWW5ZK2d1NVdCRTUxR3lLcm4xQWZueURkZ1k2Vklr?=
 =?utf-8?B?azNPbGprRElwL3ZjM1JodkxmblNuYXA3ZlpiT3VPTVY3NktoNG5JTHBVNjZl?=
 =?utf-8?B?bG1BT1FxTTRrcVlJUEh0KytBd2xUT3AzV2ZLdGRaanA2TVJkVWRHUU9EeEdD?=
 =?utf-8?B?Mk9aU2NiZ1BiUW9LMS9DUVY0amxqR0llT2RpcE1Fb0RBMG9ITVZURm5xVG1s?=
 =?utf-8?B?NTdHWHh4ZWNCTUM1WjdZTlRsdnIxQytNeWV0NTN3QUlZVjVWTCtOZFpuQlp6?=
 =?utf-8?B?d3FzbmMxVU1VK1ZucDB0aTVCK0VtVkhLWlYvTmlOeWlqMmg3MkFNWXltK1F4?=
 =?utf-8?B?T2EvaHNtendzVWwxTjBQam9FVFRTZ1NVSDZhYUpyeWNUaHNIdHNpUzN3WFdD?=
 =?utf-8?B?bmN5Tyt6bERFSEpIa0I4ekdXWmNmVWUyNWNnMU8wQm9rTUNpVmFzdEs3V245?=
 =?utf-8?B?QmVYOGtJeEtaZGFiWWUwTXEwVjk3TlRNNmFDOWlDTnhYY2tKWlhvcEVScFNG?=
 =?utf-8?B?RUNMT05mQkFOV1pGWjZ0YlBwa0lZQ0VhY3E2S0hoNk5ram82VHVGTTdJaSta?=
 =?utf-8?B?dEl3Si95anVxTEtqYllyb1ZocXdkS1FGL2QyN3lWd0pSMTA2V21udCtwTWRu?=
 =?utf-8?B?SjB6dHowbHFxdU1IMjNIZjNia2xDbHJlNFJrRDM5Y3MrMlYxdVZYbkdOaGoy?=
 =?utf-8?B?UnNvOG9ZMlRHSEhrWXozODV5YU1NdE1JcnpmU1lNOVM0QXBrN0pjejAxNXYv?=
 =?utf-8?B?QStESFNoVWtDTTNwUDFaRXUyOTBmSDY0dy9RVUN5TWFzS0gxbWhvSXdBeFda?=
 =?utf-8?B?SlAvN1ZIYkRpMXNTT2l5OUlvNHVJQXJLZVRGcmFvTFlCZ1ZTMjZvNjhZNFRZ?=
 =?utf-8?B?eThGdFlTQXRqSDFuM3JUNWVmQmtWWWZ5MVpYNVZPM2RCNzI0YkVUaGh6b2lR?=
 =?utf-8?B?MFVwOWVDWkFTV0N5VTBaRUEyT0M5VGFrK0ZiWDExMGZRSUtEb2Zpdk5pYzB5?=
 =?utf-8?B?WFlXbzRGWU1zbndodktlTXJ1cE1PSWQxTDJNZGlFVVFjTGdScnVPOU1UVjFD?=
 =?utf-8?B?bUpSVTRtWU01ZEM4WjU1YW9XVTM0aTZ6RFptQUlEcE5vb0VxWEhtcmNpWHRa?=
 =?utf-8?B?U3ZiS1RlaW16Q0REMVI3S2FGb1laTzRYc0Fzd0lDd2hLM2dIWERYeUxsTnJm?=
 =?utf-8?B?Rll1MTNua2VZMEV4cFJnVTRNcjY4ZS9VbGwzbUdSWDJTMUtBMm1TdDNldjR6?=
 =?utf-8?B?TkJ4dHYycDdDK2ZFaXQ0S3llZ1k5WVVEYkM0UDNBVlFoNVdJTlg0LzIzQmlT?=
 =?utf-8?B?UmFGVVdxWGNmL3pyajNZSU1uTGVsSGl1eGYzTE5tWU5kbXFoa003d0FpWVgz?=
 =?utf-8?B?TkVPUkI3RUgwcFBlenNod3JrbjNFUjJzNkx3blp4MkhBbHNqbzZPNVRRT2RU?=
 =?utf-8?B?Qld4dktNbnFYQTQzblpwU25rTDF6Q0hGMVhOUTRlZk9BdDZKQWZoVDJldzVY?=
 =?utf-8?B?ZmJyOEpobWlOdGhrY1pFRGlPQWE1YTNlS2hwQWlMRDdkRHdkZFBQejc4Vy9T?=
 =?utf-8?B?ejI3SnNOeHVXdnpUNDlvZWlCSVNiRjVNUFVjQURlTzROdkpvUGtxVHBLK3FS?=
 =?utf-8?B?aGYzTGpReVJlemtUN01heHZ2dkhJL3NxNnJYUDdCMDEwOS9xWWtHTGQwVDl3?=
 =?utf-8?B?ZTdEK0hQSjhIQlZ1QVlacVhHSTZNWlZHa3g2NGE2aGNVNHVVS2Q2R0hGcW9D?=
 =?utf-8?B?S0RncG1sc0RpdFlSeFIzeEM0dVZhcEFLcEZCc1BncUh5Vk5tSjJuREg1RDFx?=
 =?utf-8?B?eEFVMDNKbloxQjUyaUR1WDU2R2R6dWdSbkh3anRqVXRKakY2bkUvVXNtMjEz?=
 =?utf-8?B?WWk2TlRwakJMZGFGSFBoUGFjRk0zNUpSWWtwUkNEVFdqcFlicXJVK2JYMnJw?=
 =?utf-8?B?aDJnZS9SeW9kR0xLY1QwQTRRWGVXZ3ljWGxlc1VIUTFFSzZRZXg0WEE4WHV5?=
 =?utf-8?B?QUl5bkc3M3BuVUM0QnY4bzVrUE5HSE9UZUpZQ0ZPVW5mVHQrcG11akNkY2VS?=
 =?utf-8?B?eW82dG4zRU9pSGZWQ3dpcE43aFNGMkh1T0tyUk9YWWNORlFCRVZBckNsRXZH?=
 =?utf-8?B?T1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3CCBBCDD0D9DD044A4FA2D0656E8656A@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB7682.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 218d0ada-0981-4948-356f-08dca612bafe
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2024 03:44:15.6034
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wdGJaRhjSPxMTxwaCQ1ukw2vGsS6v2vsRrKw0wKnUUBjrre4Tg+dXxiyWjt4eVfC4SDDjgDdg9AY3leZTdyMWv2fabR3Gk7reskzD2aud+I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB8217
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--21.414800-8.000000
X-TMASE-MatchedRID: byfwvk+IcRmi6/VcDv9f0ED6z8N1m1ALjLOy13Cgb49qSjxROy+AU2yd
	bY7xfgXY9KE7L0nJx0rm7HHHEiyU5frqG4cFc/YAT7jCYv2QJPGIrmqDVyayv/t592eq2xoTZZ6
	R412IQHpF8lM5Yy7E50hPhI5nGSJu2psVbMUe5lf4vYawCsCC2kGtrAxy5ENOh8BhJvgqWBmDdq
	TJ9BXLxj+MHIPcs+Zx7YaSfIt4lQIlak3sDZbdHq+dYEguu4aVCt59Uh3p/NXQkgmW1KzbdCyB2
	QdJzFQxHidMJicb1ePd1YVQeLw+ooZJeVoWlbphSEQN/D/3cG551GakW92m5kdmDSBYfnJReEln
	3qDEHqM5Vcb2Z6HsLyJuxvASU3HZOaS9U7Z42f7il2r2x2PwtQ/i8FY2vTOBmyiLZetSf8n5kvm
	j69FXvEl4W8WVUOR/joczmuoPCq2UTGVAhB5EbQ==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--21.414800-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	D18D088409206CCE3BFC06C882F985E9EAAAE2EC0CFF9E9BF308E2FED31DA14C2000:8

T24gVHVlLCAyMDI0LTA2LTE4IGF0IDEzOjQ3ICswMjAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gSWwgMTgvMDYvMjQgMDU6MjgsIEphc29uLUpIIExpbiAo5p6X552/56Wl
KSBoYSBzY3JpdHRvOg0KPiA+IEhpIEFuZ2VsbywNCj4gPiANCj4gPiBPbiBGcmksIDIwMjQtMDYt
MTQgYXQgMDA6NTIgKzA4MDAsIEphc29uLUpILkxpbiB3cm90ZToNCj4gPiA+IEhpIEFuZ2VsbywN
Cj4gPiA+IA0KPiA+ID4gT24gVGh1LCAyMDI0LTA2LTEzIGF0IDE3OjEwICswMjAwLCBBbmdlbG9H
aW9hY2NoaW5vIERlbCBSZWdubw0KPiA+ID4gd3JvdGU6DQo+ID4gPiA+IElsIDEzLzA2LzI0IDE3
OjA2LCBKYXNvbi1KSC5MaW4gaGEgc2NyaXR0bzoNCj4gPiA+ID4gPiBBZGQgdW5yZWdpc3RlciBt
YWlsYm94IGNvbnRyb2xsZXIgaW4gY21kcV9yZW1vdmUgdG8gZml4IGNtZHENCj4gPiA+ID4gPiB1
bmJpbmQNCj4gPiA+ID4gPiBXQVJOX09OIG1lc3NhZ2UgZnJvbSBwbV9ydW50aW1lX2dldF9zeW5j
KCkgaW4NCj4gPiA+ID4gPiBjbWRxX21ib3hfc2h1dGRvd24oKS4NCj4gPiA+ID4gPiANCj4gPiA+
ID4gPiBGaXhlczogNjIzYTYxNDNhODQ1ICgibWFpbGJveDogbWVkaWF0ZWs6IEFkZCBNZWRpYXRl
ayBDTURRDQo+ID4gPiA+ID4gZHJpdmVyIikNCj4gPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBKYXNv
bi1KSC5MaW4gPGphc29uLWpoLmxpbkBtZWRpYXRlay5jb20+DQo+ID4gPiA+IA0KPiA+ID4gPiBI
ZWxsbywNCj4gPiA+ID4gDQo+ID4gPiA+IEkgdGhpbmsgeW91IGZvcmdvdCBhYm91dC4uLg0KPiA+
ID4gPiANCj4gPiA+ID4gDQo+ID4gPiANCj4gPiA+IA0KPiA+IA0KPiA+IA0KaHR0cHM6Ly9sb3Jl
Lmtlcm5lbC5vcmcvYWxsLzZmY2Q0OGIxNGU4NjVjMjVlNmRiNzU1OWZlNmI5NDY1MzdiZmEwY2Uu
Y2FtZWxAbWVkaWF0ZWsuY29tLw0KPiA+ID4gPiANCj4gPiA+IA0KPiA+ID4gSSdsbCBzZW5kIHRo
aXMgc2VyaWVzIG5leHQgd2VlayBhZnRlciB0ZXN0aW5nIGl0Lg0KPiA+ID4gDQo+ID4gPiANCj4g
PiA+ID4gLi4uYXMgdGhhdCB3b3VsZCBhbHNvIHJlc29sdmUgdGhpcyBvbmUgd2l0aG91dCBhbnkg
aGFja3MuDQo+ID4gPiANCj4gPiA+IEkgdGhvdWdodCBpdCB3YXMgYW5vdGhlciBwcm9ibGVtLCBz
byBJIHNlbnQgdGhpcyBwYXRjaC4NCj4gPiA+IA0KPiA+ID4gQWZ0ZXIgbG9va2luZyB0byB0aGUg
a2VybmVsZG9jIG9mDQo+ID4gPiBkZXZtX21ib3hfY29udHJvbGxlcl91bnJlZ2lzdGVyKCksDQo+
ID4gPiBJDQo+ID4gPiBmb3VuZCB0aGF0IGl0J3Mgbm90IG5lY2Vzc2FyeSB0byBjYWxsIHRoaXMg
YW55d2hlcmUuDQo+ID4gPiANCj4gPiA+IEknbGwgZHJvcCB0aGlzIHBhdGNoLiBUaGFua3MgZm9y
IHRoZSByZXZpZXcuDQo+ID4gDQo+ID4gSSBmb3VuZCB0aGF0IHRoZSBzZXJpZXMgb2YgIk1vdmUg
cG1fcnVuaW10ZV9nZXQgYW5kIHB1dCB0bw0KPiA+IG1ib3hfY2hhbl9vcHMgQVBJIiBjYW4gbm90
IGZpeCB0aGlzIHVuYmluZCBjcmFzaCBpc3N1ZS4NCj4gPiANCj4gPiBJdCBzZWVtcyB0aGV5IGFy
ZSAyIGRpZmZlcmVudCBpc3N1ZXMuDQo+ID4gDQo+ID4gU28gSSB0aGluayBjYWxsaW5nIGRldm1f
bWJveF9jb250cm9sbGVyX3VucmVnaXN0ZXIoKSBpbg0KPiA+IGNtZHFfcmVtb3ZlKCkNCj4gPiBj
YW4gZW5zdXJlIHRoZSBDTURRIGRldmljZSBpcyBub3QgcmVtb3ZlZCBhbmQgYmUgcGFpcmVkIHRv
DQo+ID4gY21kcV9wcm9iZSgpLg0KPiA+IA0KPiANCj4gQ2FuIHlvdSBwbGVhc2UgcGFzdGUgdGhl
IHN0YWNrIHRyYWNlIG9mIHRoYXQgd2FybmluZyB0aGF0IHlvdSdyZQ0KPiBzZWVpbmcgd2hlbg0K
PiBjYWxsaW5nIGNtZHFfcmVtb3ZlKCk/DQo+IA0KPiBJJ20gbm90IGNvbnZpbmNlZCB0aGF0IHRo
aXMgaXMgdGhlIGJlc3Qgc29sdXRpb24gLSBpdCBtaWdodCBiZSwgYnV0IEkNCj4gaGF2ZQ0KPiBh
IGh1bmNoIHRoYXQgdGhlcmUgbWlnaHQgYmUgYSBiZXR0ZXIgd2F5IHRvIGFkZHJlc3MgdGhpcyBp
c3N1ZS4NCj4gDQoNCkFmdGVyIHRyYWNpbmcgdGhlIHN0YWNrIHRyYWNlIGFnYWluLCBJIGZvdW5k
IHRoaXMgY2FsbCB0cmFjZSB3YXJuaW5nIGlzDQpjYXVzZWQgaW4gV0FSTl9PTihwbV9ydW50aW1l
X2dldF9zeW5jKGNtZHEtPm1ib3guZGV2KSA8IDApLiBUaGUgcmV0dXJuDQp2YWx1ZSBvZiBwbV9y
dW50aW1lX2dldF9zeW5jKCkgaXMgLTEzKC1FQUNDRVNTKSB0aGF0J3MgY2F1c2VkIGJ5DQpjYWxs
aW5nIHBtX3J1bnRpbWVfZGlzYWJsZSgpIGJlZm9yZSBjYWxsaW5nIHBtX3J1bnRpbWVfZ2V0X3N5
bmMoKS4NCg0KQ01EUSBkcml2ZXIgdXNlcyBkZXZtX21ib3hfY29udHJvbGxlcl9yZWdpc3Rlcigp
IGluIGNtZHFfcHJvYmUoKSB0bw0KYmluZCB0aGUgY21kcSBkZXZpY2UgdG8gdGhlIG1ib3hfY29u
dHJvbGxlciwgc28NCmRldm1fbWJveF9jb250cm9sbGVyX3VucmVnaXN0ZXIoKSB3aWxsIGF1dG9t
YXRpY2FsbHkgdW5yZWdpc3RlciB0aGUNCmRldmljZSBib3VuZCB0byB0aGUgbWFpbGJveCBjb250
cm9sbGVyIHdoZW4gdGhlIGRldmljZS1tYW5hZ2VkIHJlc291cmNlDQppcyByZW1vdmVkLiBUaGF0
IG1lYW5zIGRldm1fbWJveF9jb250cm9sbGVyX3VucmVnaXN0ZXIoKSBhbmQNCmNtZHFfbWJveF9z
aG91dGRvd24oKSB3aWxsIGJlIGNhbGxlZCBhZnRlciBjbWRxX3JlbW92ZSgpLg0KDQpDTURRIGRy
aXZlciBhbHNvIHVzZXMgZGV2bV9wbV9ydW50aW1lX2VuYWJsZSgpIGluIGNtZHFfcHJvYmUoKSBh
ZnRlcg0KZGV2bV9tYm94X2NvbnRyb2xsZXJfcmVnaXN0ZXIoKSwgc28gdGhhdCBkZXZtX3BtX3J1
bnRpbWVfZGlzYWJsZSgpIHdpbGwNCmJlIGNhbGxlZCBhZnRlciBjbWRxX3JlbW92ZSgpLCBidXQg
YmVmb3JlDQpkZXZtX21ib3hfY29udHJvbGxlcl91bnJlZ2lzdGVyKCkuDQoNCg0KVG8gZml4IHRo
aXMgcHJvYmxlbSwgd2UgbmVlZCB0byBtYWtlIGRldm1fcG1fcnVudGltZV9kaXNhYmxlKCkgYmUN
CmNhbGxlZCBhZnRlciBkZXZtX21ib3hfY29udHJvbGxlcl91bnJlZ2lzdGVyKCkuDQoNCkkndmUg
dHJpZWQgMiB3YXlzIGNhbiBmaXggdGhpcyBwcm9ibGVtOg0KLSBTd2FwIHRoZSBzZXF1ZW5jZSBv
ZiBkZXZtX21ib3hfY29udHJvbGxlcl9yZWdpc3RlcigpIGFuZA0KZGV2bV9wbV9ydW50aW1lX2Vu
YWJsZSgpIGluIGNtZHFfcHJvYmUoKQ0KLSBDaGFuZ2UgdG8gdXNlIG1ib3hfY29udHJvbGxlcl9y
ZWdpc3RlcigpIGluIGNtZHFfcHJvYmUoKSBhbmQgdXNlDQptYm94X2NvbnRyb2xsZXJfdW5yZWdp
c3RlcigpIGluIGNtZHFfcHJvYmUoKQ0KDQpXaGljaCBvbmUgZG8geW91IHRoaW5rIGlzIGJldHRl
cj8NCg0KUmVnYXJkcywNCkphc29uLUpILkxpbg0KDQo+IFRoYW5rcyENCj4gQW5nZWxvDQo+IA0K
PiA+IFJlZ2FyZHMsDQo+ID4gSmFzb24tSkguTGluDQo+ID4gDQo+ID4gPiANCj4gPiA+IFJlZ2Fy
ZHMsDQo+ID4gPiBKYXNvbi1KSC5MaW4NCj4gPiA+IA0KPiA+ID4gPiANCj4gPiA+ID4gQ2hlZXJz
LA0KPiA+ID4gPiBBbmdlbG8NCj4gPiA+ID4gDQo+ID4gPiA+ID4gLS0tDQo+ID4gPiA+ID4gICAg
ZHJpdmVycy9tYWlsYm94L210ay1jbWRxLW1haWxib3guYyB8IDIgKysNCj4gPiA+ID4gPiAgICAx
IGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvbWFpbGJveC9tdGstY21kcS1tYWlsYm94LmMNCj4gPiA+ID4gPiBi
L2RyaXZlcnMvbWFpbGJveC9tdGstY21kcS1tYWlsYm94LmMNCj4gPiA+ID4gPiBpbmRleCA0YWEz
OTRlOTExMDkuLjEzOTllMThhMzlhNCAxMDA2NDQNCj4gPiA+ID4gPiAtLS0gYS9kcml2ZXJzL21h
aWxib3gvbXRrLWNtZHEtbWFpbGJveC5jDQo+ID4gPiA+ID4gKysrIGIvZHJpdmVycy9tYWlsYm94
L210ay1jbWRxLW1haWxib3guYw0KPiA+ID4gPiA+IEBAIC0zNzEsNiArMzcxLDggQEAgc3RhdGlj
IHZvaWQgY21kcV9yZW1vdmUoc3RydWN0DQo+ID4gPiA+ID4gcGxhdGZvcm1fZGV2aWNlDQo+ID4g
PiA+ID4gKnBkZXYpDQo+ID4gPiA+ID4gICAgew0KPiA+ID4gPiA+ICAgIAlzdHJ1Y3QgY21kcSAq
Y21kcSA9IHBsYXRmb3JtX2dldF9kcnZkYXRhKHBkZXYpOw0KPiA+ID4gPiA+ICAgIA0KPiA+ID4g
PiA+ICsJZGV2bV9tYm94X2NvbnRyb2xsZXJfdW5yZWdpc3RlcigmcGRldi0+ZGV2LCAmY21kcS0N
Cj4gPiA+ID4gPiA+bWJveCk7DQo+ID4gPiA+ID4gKw0KPiA+ID4gPiA+ICAgIAlpZiAoY21kcS0+
cGRhdGEtPnN3X2Rkcl9lbikNCj4gPiA+ID4gPiAgICAJCWNtZHFfc3dfZGRyX2VuYWJsZShjbWRx
LCBmYWxzZSk7DQo+ID4gPiA+ID4gICAgDQo+ID4gPiA+IA0KPiA+ID4gPiANCj4gDQo+IA0K

