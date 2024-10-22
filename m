Return-Path: <linux-kernel+bounces-375473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61E5D9A9667
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 04:47:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 581F7281CBA
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 02:47:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90C0B84D34;
	Tue, 22 Oct 2024 02:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="fTbgN0cK";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="QcFeK/Mc"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E575423A9
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 02:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729565255; cv=fail; b=K+J/4Qvmi+G6y0QCgZOPO9Lo79mbpJwrxc2eujfH4iOz7L8V7jPkG0daXtBSgVUdTi2HeW0096eCWigeHaN+3dx3ZR++z3qMlBzom07Eh9kEzJ7Cv15FFhAsB8vtNReoD69ACcRNTkzAiznI8rFCrJ1PrcQo4+tEZZAfIN1ZTKM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729565255; c=relaxed/simple;
	bh=gwDEnJM8eCoKd/HURPgTHsON+7uJRCkrDl01NhNztLA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BVN7uIWzLhviueM/KwYj1xXFBVS3nP292HWOLe0PJMAazBrIqAmU7FiejGQY4SC5ZhDUQUFu/FT66E/UEzjMEU92pzRwCWoGSkhCqwkhUQYTq+qDxQc/tPjpP941Z4t243K+Hm0UcW2b8jDkg83k9nmW8OT/84UAcs/Fu9h3O/Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=fTbgN0cK; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=QcFeK/Mc; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: f976fb0c901f11efbd192953cf12861f-20241022
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=gwDEnJM8eCoKd/HURPgTHsON+7uJRCkrDl01NhNztLA=;
	b=fTbgN0cKpNKfHSpidos7mB3ceAipVXeaX0nA4u2ibE0NAxx21IsJsCencjEpYhlY7+3TfRwrjm8bGEAXQGHVQ2slCsdTqEZjKaDcSPus9ZyLuFsOx3H+fjW5FugFP2KQkWhWE5MSqQ7AlfLdq8DHTklqcb5spyAbD/bPyAQiTw8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.42,REQID:f791754c-5644-4785-a6bc-47bdbce339d7,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:b0fcdc3,CLOUDID:db669f41-8751-41b2-98dd-475503d45150,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|-5,EDM:-3,IP:ni
	l,URL:1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_ULS,TF_CID_SPAM_SNR
X-UUID: f976fb0c901f11efbd192953cf12861f-20241022
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
	(envelope-from <liju-clr.chen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1116276149; Tue, 22 Oct 2024 10:47:27 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 22 Oct 2024 10:47:26 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 22 Oct 2024 10:47:26 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qc0Eg6BwaEveODZ4NYkq9kAri0t3xtnIn1OdORlNFnKnvhPJlJs76yfZ6dJ36I6gGtBsu/g+zCnqqVu+qV97IwRJBYBKK2oJGzIHpCr6FoMUxqqbWOSOz+Eyeu4ee/WiXbwYZHlS2dazjw9pBixk4ie2G1aIjq/7hSgSzrIxlsYFCKZw6Qcaz6UlRiHeVnMWIgIHtwC+i19HbqTsax+5C4irGUe9sUGfDevEuHiu4dllABJL5IsowRXGWi5A4Li3aSU9T48Ns/SB5Szzs9Sx34FpvZv5D+GnTwn8SLe137S+B/4/yCdp5o0aCmqKRXfWVdZI0VdmybECBQNTXvoSBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gwDEnJM8eCoKd/HURPgTHsON+7uJRCkrDl01NhNztLA=;
 b=NyNFj+GktSXBZHDik4x93UOgRbm0oCbZwhCDlXvkP0DCK6VkV+eC1K4qupOjdQeA4x458fdrvvLB3LUmPuOM+sYRO+3rgRCHzdm7PCgGSt9kPqyg8Cex5cxsVy/VFp7J5+g45KvgHW6zZWs9DBpEVfgZfRI9IZbdp7pyBDA/Yn8us50mVaG16JY8GjCZO91JG9srj2iAgFFe6vbC2i3NdWiS5Ogr81EYFGvWE8E24P6H3z04OFAlOfZrwfE0qhnwEGucB5Dk4u9MLutZoZLOrkATGdyzqi7p41wwxB2bjYqsmBDq2YzuOCy3sAAFhW8y7gcR+VPdWIt/ZMq8/sLOEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gwDEnJM8eCoKd/HURPgTHsON+7uJRCkrDl01NhNztLA=;
 b=QcFeK/McSK4JQ0fRrTaxaYLUWD3Ll0wU9IC7CmNvUDfbEVJUuXIm4kg0S0D9tnd63tqpaA/1Klk+Hw6ys1gCjEkC1nk/VwT3hOpsT5qsaWviZzXS63lD6GFOU/6vxcwNMueIXE/CY3Kmvb3c+1RxTwbHM71N1S0NnuLWTSB+t50=
Received: from SEZPR03MB8273.apcprd03.prod.outlook.com (2603:1096:101:19a::11)
 by TYZPR03MB7292.apcprd03.prod.outlook.com (2603:1096:400:426::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.27; Tue, 22 Oct
 2024 02:47:24 +0000
Received: from SEZPR03MB8273.apcprd03.prod.outlook.com
 ([fe80::f7ac:70cb:3cb4:acac]) by SEZPR03MB8273.apcprd03.prod.outlook.com
 ([fe80::f7ac:70cb:3cb4:acac%7]) with mapi id 15.20.8069.024; Tue, 22 Oct 2024
 02:47:23 +0000
From: =?utf-8?B?TGlqdS1jbHIgQ2hlbiAo6Zmz6bqX5aaCKQ==?=
	<Liju-clr.Chen@mediatek.com>
To: "hdanton@sina.com" <hdanton@sina.com>
CC: =?utf-8?B?WmUteXUgV2FuZyAo546L5r6k5a6HKQ==?= <Ze-yu.Wang@mediatek.com>,
	"will@kernel.org" <will@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
	=?utf-8?B?WWluZ3NoaXVhbiBQYW4gKOa9mOepjui7kik=?=
	<Yingshiuan.Pan@mediatek.com>
Subject: Re: [PATCH v12 03/24] dt-bindings: hypervisor: Add MediaTek GenieZone
 hypervisor
Thread-Topic: [PATCH v12 03/24] dt-bindings: hypervisor: Add MediaTek
 GenieZone hypervisor
Thread-Index: AQHa4loHiJrN6un+gki/bsychUC2ErISOLeAgIBcBAA=
Date: Tue, 22 Oct 2024 02:47:23 +0000
Message-ID: <620a0368b25708842007cede107baa21a7370c24.camel@mediatek.com>
References: <20240730082436.9151-1-liju-clr.chen@mediatek.com>
	 <20240801103647.2480-1-hdanton@sina.com>
In-Reply-To: <20240801103647.2480-1-hdanton@sina.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR03MB8273:EE_|TYZPR03MB7292:EE_
x-ms-office365-filtering-correlation-id: 0d0952f5-4563-4307-4890-08dcf243db30
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?aFp5TXJ1TC92VzhQRStuSXY4ZXNGSWtzU01kYUw4dTA4V1dkTTVONUFjaVVi?=
 =?utf-8?B?VVdqRWxObHNQT0ZES2tKakNvdzlwZEhnM3Z0TGlzSFdieUY3VUE2YmwzUVEw?=
 =?utf-8?B?QnB1Q1BBdElnZkJBeU5EZlh2Ly9JNE40TklMMTBMcWlqMk9XYVlRaC9aa3Fj?=
 =?utf-8?B?MkgrMStZTnBFNk13akdzS05xZi85ZXlCNlN6THFWSWNtT0drMGFrWmQrazV1?=
 =?utf-8?B?bFFzUncyTW5HR3JPZVdwTm44MlZ2YnhPNDBlN0JuQlVrV1o3dmxDUXRBQlFL?=
 =?utf-8?B?QkJVMjlYUm51MWVGMmhTKzBGTUxHaHAyamQ4eEF6Qkx4R292c2dad0ZjUHRT?=
 =?utf-8?B?WnpYVmZaWVM1bjVQWXdpQXFPVzg4WTBEV000MU40YlVEWUNMK2FqYTJVck9S?=
 =?utf-8?B?RW9hUGZIcUVYUFdRQkE0elJPb1pQeGxvMk9XNHZrVUJQb09hZmVYUjdVUkp3?=
 =?utf-8?B?ZmNqbkFKRTA2VmhwRTdsdDNYOXMvdWNucnoxMXg4cmhvQldzcXJ5dG9mQ2FM?=
 =?utf-8?B?bDJrV2ZTTGRmaDlvSUNIbFFIRFRLbngyS2hEUThSSnh1SVpTYzI5eVoyWWFQ?=
 =?utf-8?B?T3BrWVRRQkpMRENycElvSmg1aTU1ZngvRXZnN0dvZDJkSXlVZjhEQnQzYWJG?=
 =?utf-8?B?dzJ6RXlPOU9Fd29EaWtUaXZjQ1dZZzBuTmRMK044blB6em9nS1VudGdRSjZO?=
 =?utf-8?B?ZWJSZlBxUHdaTnYwVTRJU1pQRU5xMWl1d3piR3krWVgvWUgxaS8xK0ZMUTJE?=
 =?utf-8?B?ZHFON2xCZXJHQkdnWTZubUM1bnowc3ZDT2FNaWJGYjZJRFM5UDBjc1dCYlAw?=
 =?utf-8?B?S2hjK29NZnJsSHpITW1vSkNDMmR3aHZpTStaS0ZFcVNZc2VoR2lEUUJwMmM3?=
 =?utf-8?B?ZHZRaHVGYkpkd0c0ekhidnBQS3Y1NlJWV3dESnREdVBUYnNKNVByK1J6c1Br?=
 =?utf-8?B?Rmo3MUhNR2MxaGhaNTJZZ0xkZGNVVXFhZEtSbHZIaEw2Rk56VVQ1QitEemJM?=
 =?utf-8?B?ODRQdnAyTjBRdHlCM3VpaGNhMzlscU9zaXhhcjVXL0R1RzNTTG90UjJsSkpq?=
 =?utf-8?B?VXVrU001ZjNDTkV3TndzUUQzMVNOSTkvVlRmbFRxNmRXcFdvM0VaeTlkLzZY?=
 =?utf-8?B?VGJZOGZHU2dTbVd5ZXF1Z0pacSsxR0liSlRXcGlMamRzcVdnL2d5WkNLS3pm?=
 =?utf-8?B?V3I4UWJ0b2haRitiTWFDQ3d0TG9SWUtrbmhZU2hWVEliMUl4WUJBY1lEUU05?=
 =?utf-8?B?WHdxN0xMd1Rjc1FHZzdxRUdZNktJSjFPK1lqeW9SVHF6d1dwY1BlbTFpUnhk?=
 =?utf-8?B?b2pJNmx4THdNTnlxSTRZenZCRW04MHlqL1BubjBtSSsvRzRlYUp3YSt6UExO?=
 =?utf-8?B?dmkveTJQZmx1U1Y0YStJRWlNN201RnkyQVFxSTNGSC9XT3I3ZjNEM0xRNmY0?=
 =?utf-8?B?bDJvMHRUT3BNQ0t5SU9sSXZTTklXRW1KZERQVHNWeXJGM1k2aUVaWXRqVGR6?=
 =?utf-8?B?dUN2YWNjaWpCazhac3R1dmJHaGFoTnR1dk94RHNramR2ajU5QnE1UTREVzlR?=
 =?utf-8?B?eDRJaVB3Wlg1ayt1YjBhYyt3L0ZMMXhvSTBPcEMrd3BWNGY4djhHbEM0ZVJ5?=
 =?utf-8?B?MzY3RlZxb3RQUWlIVHFTdCszbWhzR0haME9NdGMxRmZ0elhEdEJlT20wZnVJ?=
 =?utf-8?B?eHp5SXVLYXZkaUFIbk5pU0owanpWdzhDNk11QldxYmptejYxcjIxVkIzaWty?=
 =?utf-8?B?NVp4NzhNa0g1OHZxYWRsYXVIVTI2bEEvMnpuMWIrU3ZMMlc4d3dzR3pZUkND?=
 =?utf-8?B?R2EreEVFN09zSjR5WitSclhGRWIxd25CYzNFWDU3c2hPZEQxSjFKcFdTd1gy?=
 =?utf-8?Q?+cR05u04nYghC?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR03MB8273.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NjVoOEhSLzV5QWM3T09QanZaNEVrK0VVM2JaRTdNbVJ2N0FZckVSOFVLcHh5?=
 =?utf-8?B?QVBPWWd5UnBFc1NISnN3SFJ3WmtFZTdoR0dFK1dubzcwMEYwVEljYzhrTzlm?=
 =?utf-8?B?UFpURndlNGpLYzQ4MTBsWWRML2hKcEg2aEtQN2JWVjJ1ekhoN0l0aUJOK1NQ?=
 =?utf-8?B?clZoY0wzM1JlQXpqUVZhVWxKOXVkOVhFL3lXbU92TmttQTcwbHlBS00zZzNJ?=
 =?utf-8?B?YXNycEJ4Q04vMW5saEovRjZWODh3Yi9DQ2I2dUNVdC9WcWZvNWR5cktIN3hv?=
 =?utf-8?B?cnN0cHZsQy9TK2U3M3YzTGFSVmNsN2JMNFNhZ3daeS83VzJPS2I0SkpXTlFR?=
 =?utf-8?B?QTNKNXE5RUlEVnEza3JSQXhOeGUzTjh3eDBjR3V2ZXBncXRtanV3ZmZBV2dx?=
 =?utf-8?B?TFVGNU5leXJZS2VRanFUZmZjTGt4Tzd3VC9xNmlPb0x5d2JZZy9OOWRIRzg4?=
 =?utf-8?B?NmlYNHJOT3pORzBXQkdGQ01EQllxUUZOVTYzZ3ZkeXpNbmlYWFJGZHpiZDFW?=
 =?utf-8?B?NHlqemp2OE9LVzNOOTd2eHpRS0ZlSmYrUk5UQnloaVJhUXBzNmpFRmF1OEZy?=
 =?utf-8?B?dHpYVVo3UjU2OExqalQrN2dqbEQ5dHEwOGpQV0tXUmtwUXhOb2ZEN0pDSmlM?=
 =?utf-8?B?SU5BMDJIK1ZPTDU5dGdhbTJsNWFRSkQ0Y0tUTUxYWlNXa3RyYXJmdGlwTXhV?=
 =?utf-8?B?YUo3R2lRY2E2VmhpR3dCck1WUS9FTWRsU3lXN3RWZG16OFRqc1ovWC9Ubk5N?=
 =?utf-8?B?YjRXMnF1ZVhpVXFWbEtvTEhTUnNoeU1BMjZxRnZGNkRnNjltU2l2dXdCRWhk?=
 =?utf-8?B?Qkc1NWdHY1IzSTJKSjlQUUdIb2VRQk1JZTZRaW05UDFFNkI1c2ppWjJnOEJ0?=
 =?utf-8?B?MFhQb2dkOFdMby82by8yakR2cElMbXMvck5sTi9PdC9qcnZwWDkxZ2xKOU5i?=
 =?utf-8?B?aEtHV1NaMXNlM0U1aG9MMkxKQTVpRG1Mam1sL29TTFFGc0NsaWRTRzFJMkFz?=
 =?utf-8?B?d2ovTnkzdXZFTU5PYWQ2dnFMdDdGdUxYTzhxS3Z5RnhndGdnM0N0RWZKTEZk?=
 =?utf-8?B?SVh5UnJteERjZXJ6NTlud1dMVWh0amh0c3dOdUc1QTBYcDZYT2tMZThiWTEr?=
 =?utf-8?B?WTltQmpTdzZsZmhLWGZFa2NJQVVVWjZQV1dkcVVQSGg4SGN0bjlNSVFxSFEx?=
 =?utf-8?B?MmFYRWNZSXgwSnZaUy9yNEdFdDNpdzA4SmNOdXNmaXdwTm42TzBRQ1RMbDFI?=
 =?utf-8?B?Qkt0YXlvTlB2WUwreDBwYWNKREwySTlwS0ZPa0hRUWpOa2lDYWN3TWI3cjYx?=
 =?utf-8?B?dEhoZkNLMnltenVwb0xGTjhJc25sTmVoUHB5S3ZPYVBsVGJhMDhwTXNhZG1L?=
 =?utf-8?B?ZHZVNXQ5aTlBeUtaVEZLMmF5V1lYZU9EL3ZMY0pDSENaYkt0cUpVdlowcDZR?=
 =?utf-8?B?WE9TZzV1S0xVRHczS2d3ZUFIWHVBSmZNZFVJMklIcFF4bVBoa0tMb3dRRlJ1?=
 =?utf-8?B?MGZ2NHZvQmo3RXlBM1J1a29OWTEzdHJSQldxWVhCK0VpZDRYV2NnaENFTWFn?=
 =?utf-8?B?L0JBOWw2bTM4blFGanVIOHd2NjdGYzAvNWhlekZEWmUydmRYRE1OaXZObmEw?=
 =?utf-8?B?RVY2aFg2KzRqRFlpdDJlSWtjV1R1VlQ4OFZaNmZKb3R0cDU2WWdNOThUOWdJ?=
 =?utf-8?B?YnBTa213amNUQUNqUHFDTnFMQXRaRHptQW9ZdURobXMraklYUE1pVGdUckxs?=
 =?utf-8?B?Um9UbDhwODlIbWprcTlxalJONmljK3BWQ2N5bmdNdWF0M2o1N3BwSFA0N3hw?=
 =?utf-8?B?YmlXQWVXYUNJM2NPcEVqeFpFTHdEUlBlMnRMR0NUVCttb2R0MWN0RmZUOWxv?=
 =?utf-8?B?WkFvUXB5d3FsTkg0MTRyeE1pVlRiNGVHY0RNQ1E3M0hPTS8rcTJFRUlHMXNx?=
 =?utf-8?B?R0NFUUtBNUd6b05TMWo5ZTI3L1lwMTVTV3BWNXRtdW9QWXI3TnpGK05Ec21i?=
 =?utf-8?B?UU9pNVpsaXRXSndRRUZKWTVMdnNkTjdxV2FqR1NNQ0ZVYWdqSnpsaFJ4YkFw?=
 =?utf-8?B?bDZPU0ZaUTNGK2dLYzRsR2EyR3NDU2lyYk8rUjlEcEVxc3pOd2J1ZnpUU1RG?=
 =?utf-8?B?c1Z6VXhhMUlNc21vcnhQcENtaHhIYk1yWVNiNFBzYmNQK1FZcDNtVTJNMFNy?=
 =?utf-8?B?b1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3B2857DAFD10BE4CBBFA7E4FFEAC1390@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR03MB8273.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d0952f5-4563-4307-4890-08dcf243db30
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2024 02:47:23.3351
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lL7cKFBGVAKWu7HCOMasco1kvvjdGgaGnpYo7iLbRBn3HJ/D8/epLY1cbLClgPcZ+89O9Zb89A3ZudQraupXFktU5fJanpFOyMNATSJ9LBk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB7292
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--27.170600-8.000000
X-TMASE-MatchedRID: c/HXCguHooHUL3YCMmnG4ia1MaKuob8PCJpCCsn6HCHBnyal/eRn3gzR
	CsGHURLuwpcJm2NYlPAF6GY0Fb6yCpGpaLcbZyfwdrnuu4cCcfF+Mk6ACsw4JtzOQo7mTgA+4UK
	TAfgEjW+ks5yuIoo6qGecCQkJfD9tFTDkiWbzfXaFzl4vWFNGP+Kpsymq1FPb+3n3Z6rbGhNhej
	p7pwzKTPI0EW3LDn/3LD+H50fx9Wgv9901qElB+hlckvO1m+JcKhNpTcvbdUKU8ftiyKjZrZWLo
	gQ9q5U3hLNJRXjepiseYZj+jjPzyUL9tcyTZdAsgxsfzkNRlfKx5amWK2anSPoLR4+zsDTtAqYB
	E3k9Mpw=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--27.170600-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	78AAAA113B5EBA6B030AF75E6339EA638CAE57390CA45B3EFC55094FAAD92AC62000:8

T24gVGh1LCAyMDI0LTA4LTAxIGF0IDE4OjM2ICswODAwLCBIaWxsZiBEYW50b24gd3JvdGU6DQo+
ICAJIA0KPiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mgb3Igb3Bl
biBhdHRhY2htZW50cyB1bnRpbA0KPiB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVyIG9yIHRo
ZSBjb250ZW50Lg0KPiAgT24gVHVlLCAzMCBKdWwgMjAyNCAxNjoyNDoxNSArMDgwMCBMaWp1LWNs
ciBDaGVuIDwNCj4gbGlqdS1jbHIuY2hlbkBtZWRpYXRlay5jb20+DQo+ID4gK2Rlc2NyaXB0aW9u
Og0KPiA+ICsgIEdlbmllWm9uZSBpcyBhIHByb3ByaWV0YXJ5IHR5cGUtSUkgaHlwZXJ2aXNvciBm
aXJtd2FyZSBkZXZlbG9wZWQNCj4gPiBieSBNZWRpYVRlaywNCj4gDQo+IEdpdmVuIHR5cGUtSSBb
MV0sIGNvbmZ1c2VkIGJ5IHR5cGUtSUkuIFdoaWNoIG9uZSBpcyBjb3JyZWN0Pw0KPiANCg0KSGkg
SGlsbGYsDQpUaGFuayB5b3UgZm9yIHlvdXIgY29ycmVjdGlvbi4NCkdlbmllWm9uZSBpcyBhIHR5
cGUtSSBoeXBlcnZpc29yLg0KQXBvbG9naXplIGZvciB0aGlzIHR5cGluZyBlcnJvciBhbmQgd2ls
bCB1cGRhdGUgaXQgaW4gbmV4dCB2ZXJzaW9uLg0KDQo+ID4gKyAgcHJvdmlkaW5nIGFuIGlzb2xh
dGVkIGV4ZWN1dGlvbiBlbnZpcm9ubWVudCBmb3IgbVRFRSAoTWVkaWFUZWsNCj4gPiBUcnVzdGVk
DQo+ID4gKyAgRXhlY3V0aW9uIEVudmlyb25tZW50KSBhbmQgQVZGIChBbmRyb2lkIFZpcnR1YWxp
emF0aW9uDQo+ID4gRnJhbWV3b3JrKSB2aXJ0dWFsDQo+ID4gKyAgbWFjaGluZXMuIFRoaXMgYmlu
ZGluZyBmYWNpbGl0YXRlcyB0aGUgaW50ZWdyYXRpb24gb2YgR2VuaWVab25lDQo+ID4gaW50byB0
aGUNCj4gPiArICBBbmRyb2lkIFZpcnR1YWxpemF0aW9uIEZyYW1ld29yayAoQVZGKSB3aXRoIENy
b3N2bSBhcyB0aGUgVk1NLg0KPiA+IFRoZSBkcml2ZXINCj4gPiArICBleHBvc2VzIGh5cGVydmlz
b3IgY29udHJvbCBpbnRlcmZhY2VzIHRvIHRoZSBWTU0gZm9yIG1hbmFnaW5nDQo+ID4gdmlydHVh
bA0KPiA+ICsgIG1hY2hpbmUgbGlmZWN5Y2xlcyBhbmQgYXNzaXN0aW5nIHZpcnR1YWwgZGV2aWNl
IGVtdWxhdGlvbi4NCj4gDQo+IFsxXSANCj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC8y
MDI0MDczMDA4MjQzNi45MTUxLTMtbGlqdS1jbHIuY2hlbkBtZWRpYXRlay5jb20vDQo+ICsrKyBi
L0RvY3VtZW50YXRpb24vdmlydC9nZW5pZXpvbmUvaW50cm9kdWN0aW9uLnJzdA0KPiBAQCAtMCww
ICsxLDg3IEBADQo+ICsuLiBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMA0KPiArDQo+
ICs9PT09PT09PT09PT09PT09PT09PT09DQo+ICtHZW5pZVpvbmUgSW50cm9kdWN0aW9uDQo+ICs9
PT09PT09PT09PT09PT09PT09PT09DQo+ICsNCj4gK092ZXJ2aWV3DQo+ICs9PT09PT09PQ0KPiAr
R2VuaWVab25lIGh5cGVydmlzb3IgKGd6dm0pIGlzIGEgdHlwZS0xIGh5cGVydmlzb3IgdGhhdCBz
dXBwb3J0cw0KPiB2YXJpb3VzIHZpcnR1YWwNCj4gK21hY2hpbmUgdHlwZXMgYW5kIHByb3ZpZGVz
IHNlY3VyaXR5IGZlYXR1cmVzIHN1Y2ggYXMgVEVFLWxpa2UNCj4gc2NlbmFyaW9zIGFuZA0KPiAr
c2VjdXJlIGJvb3QuDQoNCkJSDQpMaWp1IA0K

