Return-Path: <linux-kernel+bounces-188228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C295B8CDF78
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 04:21:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C83A1F222A3
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 02:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFD4823774;
	Fri, 24 May 2024 02:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="HYymzAyl";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="af2qXCeU"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C721A286;
	Fri, 24 May 2024 02:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716517310; cv=fail; b=dfXfkdMrOIuJbTXdjgLtM33N89YOtF65FyiatyK6ZqTzixr9xUZQb+WMwGXwrskD7TBATgsx3ezzGrJqDxd3/w/ocyRn7XiMEog8vlM0g6g17ff379uVAxh7wonZAQvPv5qTzrX3fqpZW0byKhKCDRSvHJwX/UyuGvtNvBFjxvs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716517310; c=relaxed/simple;
	bh=jgQn3LDxc0Fy86S36SJb+KjG6+uKE+zk8eQFr+07lWY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SJVzpGLp49Ma3Asze/6/32WvVDNZIhN87QL0SzILNj3fC7c1COk90/BDIsZjRBQ0wqHTHE/kYqp7v6VvjrxVbd7zazncqb3e95kGrdQHhHMN2foLYsUrCAQUFsQZr4jViqHWjS6Jz4Sb116iPclxzKxrxIxsRcqela244n50wX4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=HYymzAyl; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=af2qXCeU; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 5c382978197411ef8c37dd7afa272265-20240524
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=jgQn3LDxc0Fy86S36SJb+KjG6+uKE+zk8eQFr+07lWY=;
	b=HYymzAylpXK/StdJ4e/WiKaliY+dmppOrBomd1DT+ln4HIC61EWEKPBX0HqxOH2gB9mTQgqszyGhAKa273FVDs838HDFDNo1MXbDhoNiQLpXIFGJBU+fmkAlKNdzMBqnGv7snGQ6ESjB5lzcCUjjFKPtfa5hcgH9nRDUQlv6SKg=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:0c8b85ea-e98e-4d66-a150-db929cc32c96,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:82c5f88,CLOUDID:778c3f84-4f93-4875-95e7-8c66ea833d57,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:1,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_ULN,TF_CID_SPAM_SNR
X-UUID: 5c382978197411ef8c37dd7afa272265-20240524
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1943806829; Fri, 24 May 2024 10:21:42 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 24 May 2024 10:21:41 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 24 May 2024 10:21:41 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zm6DiDNWfftK0HpMqMJWpd/N02i8Q/jCa7UrguYB/jZa1EnLfrK44MROjtNFNqab5Ukv/TZNSLDIchYlEgyT0lmRBWuFqFV8/A27zTMRdYbgu6hn8RaNF2aiZ+rrVzE8tuEp8oa8CCOkP8Mfuvouf3RbsStnlU/zd28eQodY1SyycNVMnF5JHC5yg0gXgtSJbfmCxK+MKtGmbkiRpTVrGB7c11joLx9r8OMW1i6URHGJ/U+gHDCCGjA6qMQXp95zzfqe0Ob8KJ/mLfnFnPh4izvf3V8vkRpgZLT8g1zl+ouTPnIC+mCqBGS1VcIlg3Gt1rDlBSIWJGlTtN9/VqoASQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jgQn3LDxc0Fy86S36SJb+KjG6+uKE+zk8eQFr+07lWY=;
 b=Jo/TlhPK9tPyMdGL1oO1aTH5LUiYNqv9LdBWPYjEuZtnBfnRqzdgd4uiGd0yI0moXVLR+KfcU38Ih/FlOdApqXC/AOp2XYp9h8XggN77leRMqtoOUUgmb2sJirq9/HwxyA3mhvtioUObfxwhBOJVAutg52K5rwqG/9YeoahYy+mRN7GUr5ISyFS/hw6+SXFgb7CSlqws0BJSAcpJIOcDPVb4ZL3pl9qEKwg8c8NOLDui/qpLg5nKft5kpu+6iU68JWCyt03u9IlM2xm6kb2l13VDUCCAg9KJxY5FJ9rLGjujFzGTP21ZIRNh5jsmPxz6R9qKsxK+pTISRnxOL9zLOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jgQn3LDxc0Fy86S36SJb+KjG6+uKE+zk8eQFr+07lWY=;
 b=af2qXCeU/VAj5vMLJuJ3yLNrSLoiZiBJOKEXTjOEMTvOY/LpqxeEWoJxjdGoH7CXSyA2B/BDa85PPfF9eLBemX/z0sVbmByXl7hjuwU/9c0WaAKoh6gVi20oY2ZSwBeYaHawpt+D3z0aoIPTceJrrS/5Gs6JMwl8dmPTX+M3wAU=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by TYSPR03MB8059.apcprd03.prod.outlook.com (2603:1096:400:470::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.17; Fri, 24 May
 2024 02:21:38 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54%4]) with mapi id 15.20.7611.016; Fri, 24 May 2024
 02:21:38 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>, "tzimmermann@suse.de"
	<tzimmermann@suse.de>, "mripard@kernel.org" <mripard@kernel.org>,
	=?utf-8?B?Sml0YW8gU2hpICjnn7PorrDmtpsp?= <jitao.shi@mediatek.com>,
	"daniel@ffwll.ch" <daniel@ffwll.ch>, "p.zabel@pengutronix.de"
	<p.zabel@pengutronix.de>, "maarten.lankhorst@linux.intel.com"
	<maarten.lankhorst@linux.intel.com>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "amergnat@baylibre.com" <amergnat@baylibre.com>,
	"robh@kernel.org" <robh@kernel.org>, "airlied@gmail.com" <airlied@gmail.com>,
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>, "will@kernel.org"
	<will@kernel.org>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>
Subject: Re: [PATCH v4 01/15] dt-bindings: display: mediatek: aal: add
 compatible for MT8365 SoC
Thread-Topic: [PATCH v4 01/15] dt-bindings: display: mediatek: aal: add
 compatible for MT8365 SoC
Thread-Index: AQHarQ/MdlmTt4EDEESzfVYSujeVB7GlqBYA
Date: Fri, 24 May 2024 02:21:38 +0000
Message-ID: <eee545475a62674b0a34ef3a36b2ed58ab3b0abf.camel@mediatek.com>
References: <20231023-display-support-v4-0-ed82eb168fb1@baylibre.com>
	 <20231023-display-support-v4-1-ed82eb168fb1@baylibre.com>
In-Reply-To: <20231023-display-support-v4-1-ed82eb168fb1@baylibre.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|TYSPR03MB8059:EE_
x-ms-office365-filtering-correlation-id: 7040015e-e215-434b-731c-08dc7b983e09
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|366007|7416005|1800799015|921011|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?QU1XN2RwZlRGNWs2cEhDMXFhNk9iaExRWVB5MW1QOUJZekFZTWo1WXI5b2Z0?=
 =?utf-8?B?SzlQR05UU3NHK05nMkJnbmhhTkM4UkhOdlFLc29Fd0NWaFY2N1VWc0VZaU8y?=
 =?utf-8?B?RXY3TngvSVFQTWlXL3IvdmRBQlJFWUl4WTFvTXdaZVFDbklLVXF0UDQybEpi?=
 =?utf-8?B?SEFrZUNMeXJCN0V4TzVHZnZ2Q29oQWF3ajZscFRxWDdMVFY1TENHUkVIZmlR?=
 =?utf-8?B?RkVCcHI5bTlxUTJMVjJFYkg3K25XZjVtcld3aHF2Z1NVTzBiVlRSaU5LL0da?=
 =?utf-8?B?NHROUDFvdkwxTkRadm1JMFNYREZUOFZ0QVdyUGRBS3Zxcm9CdkMvb21JOERV?=
 =?utf-8?B?d3FVYzRuTlA3bE5tQlRaN01JTEVwd1lKYzVxbzJ4NnFUZ1ozZThISkg2Nnk2?=
 =?utf-8?B?TGVqb2ZIaE5ZcU1rWHE1emFWQTN0MFVxdEVlMUVHbk5RL1pyNHpxOTZSR0U2?=
 =?utf-8?B?a2dCdjNjUzBCTGZOU1pNMmoxeGdleVprNnZrcnk2MHc0SCtkVS9ad0czWjVo?=
 =?utf-8?B?UnNYQWpyTVlTeEVqcnQxMXRkcm9YSkZaYmtuWU5WS0F0aWtYZm9ZY1JONGQ3?=
 =?utf-8?B?ckgvUy9MV2c0WXA3WHYxVTVpdThsanZIelRLbnMvVWZuRVYzVVkyRjBCMEZM?=
 =?utf-8?B?THQ2bjlxWU8vUXZFSzdaQUZYNXRoYi94aFpzTUtCTUx3dWhBWmVOb0dQOVVR?=
 =?utf-8?B?bjVlRHYwOUdRMXJvb21RY0dWeUp6MWtMQmc2R044aUU2cVVjVGtubHFXYlEz?=
 =?utf-8?B?a04va2pFWE5RbzlwT2tpVmsvaU9OMGYxZ1ZRQ1RLMDY1OHZvdGVRcGN0RDla?=
 =?utf-8?B?SFV3a2QyYXovTE1FeXFnYS9CaVFHYklwZWhra2UwMnNvcHFST25ZUVl5cU9s?=
 =?utf-8?B?ZVhRN2Z2M3lYYnhwNlp1cXErYmpneVJkMjJQa2k3a0F5RFE0bU1OcTd3WENs?=
 =?utf-8?B?SzlpQWsvVFgrMUVGckNaZStqL3VJeWpnZnpodHlxUzhkVUdEWUMrVmkrRTFr?=
 =?utf-8?B?NjhlT08zTlR6elVYWmViZjFNMm5UeC9FVVBaRThiVnp2Q0kwbVNGR3VzY3Jy?=
 =?utf-8?B?OW4vVVVTSFgwU3Fla1k1RkJ5Y1RnY2FsSWZHWnVySkNCZXJWLzVUaHlTRzRr?=
 =?utf-8?B?b2dTTWxSUHJHUE4vUThLSTBaQm04aGxXWUwrY0dLMXd4Z1JpaGVkTHVuckgz?=
 =?utf-8?B?V2V5aUpHbzRZVm5EaVBZK2UydUxtTlQyTTMwai80RURLZEdOODlub1ExQ2F6?=
 =?utf-8?B?dVdMTkhXZ25sbDd4T0pBKzdTekdIQTZGSFNGWWVaRktsbm9uOGpFYzByUXpJ?=
 =?utf-8?B?VDZZNnBNRFlpSHRieE5BM01kbVJhWmd0NDJGU1dxLzE5c1M1TnovSWtWQ3J6?=
 =?utf-8?B?ZlJ4a3R3b28zS2xSeHRPRGZUTUxjVTlXWUNCdG55Vjd3UGpRb0gyRlJkZ2Rt?=
 =?utf-8?B?RThHNDRJZmtpQnFJYXZhYkNjZGxnQURzdVVOL1V2eVM5YUhyYU5XVkM4cDFD?=
 =?utf-8?B?MlZjV2ZYbXAwZTlCOE9WYngyTXYza2Z2RHdUZDFCN0hVM2gwdmVmbVhYSWNF?=
 =?utf-8?B?d3pCRHRBUHphS1hyTVdpaWZGR2VaV2s5aGVLUDJIL091TjhZNllKODd2bDlw?=
 =?utf-8?B?eUZNdlBLZExqem45NEZEcUVmQ1ZzczdPT0h5UjdKL1NkYVJWcUNzcmkzeSs2?=
 =?utf-8?B?VlZaUGFWd1dvMHFjb0IzYzVvdHNrdGVmVlpGMzVWWWZSWWV5cUVkY1ZaUTB5?=
 =?utf-8?B?ZmtPQjhOR2puUEZZRXlKS1NZUzMwUkluTFp3RlNMSnUyTktKTmUvdDJXRGFw?=
 =?utf-8?Q?ny5DXRNxV9hy+YuNx272leF/jKaTLF/FK9cmo=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(7416005)(1800799015)(921011)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NzJibk5GTE1xd09kYk5DNHRMODlSb0NoeURiemNoMERMbEtpeTlOdDhaeEFq?=
 =?utf-8?B?RGl4Vks0WDk3VDJZcEFiUHd1bXI3NDVjZ1VoSXpMSlVYenYySGVOWmtPRzlH?=
 =?utf-8?B?bUZhNFJ2UFNXNUpINjdOQ3p0YW1sVDBheUlKQk1ZYXNpeHJIcDliSmRId2dx?=
 =?utf-8?B?VUpNKzRSSVVyL3pUdklMTWt6UEI0TDFlSXExQi9FSXNVd0dvc1pQLytHWVZN?=
 =?utf-8?B?aWFXL1FzNWFJbXd6enFTZjk4ZmRyTERzYi85K2xrekRsQmU4aWNqSFMrTTJq?=
 =?utf-8?B?M0w5b3ZYdlRVYkxjRGx1ekt5VkFhSGwyUE45RmwxZ2cybnhDeHQwTFJFR0R3?=
 =?utf-8?B?MisrSDdKVGVySG9xR0RKenB5VXBTSDVOYlIvUnJIYzF0RmpjeEk5Q2E3Y3hQ?=
 =?utf-8?B?bE9DYnRrYzZXR08vckdvbi85enB6WGtzMlJheFNzMEZaeTJZREN4UzI5U2tY?=
 =?utf-8?B?cVhrZ0I2V2syYmErOGFrYXpnUGRpUko5aVdPRDNrS3J3NWp5MlNjelMyNC9G?=
 =?utf-8?B?cGY1QThiNzRZdGhWWU5jMnpidW1SR3VScjhMRkFvNEU1VEtlbjZBV0JqejFF?=
 =?utf-8?B?aEJtWTBscy82SEd6WnhuMGUwbWttQzNBNVRUZWlhck9nWWV1c1NiU29VSVMz?=
 =?utf-8?B?a3ErMGdZamdEUlNzWXNXSnRWMFhEdGFGOTVlRFRCVDI3eTQ2QXhFUDBxY2Fk?=
 =?utf-8?B?ME84NHovMGVvZHFiTDJFTGNJOTZKejRsVnVWL2xOaFkxZm4rckIwTWdxa1V5?=
 =?utf-8?B?WUpaeVZpc2l2OXVBSFMyZTAxTzg5eXFyZFVMUjZsaGVkNHBHV0cwUHJOT2RG?=
 =?utf-8?B?VUtHTllrQ3B1Q1hPYkZoclJSSnFHZDRFLzZVVnlySi9xODN1akFPUkVxb3l4?=
 =?utf-8?B?Qm1uV3hXL3F6M3NYQUZlT2NqcjhXT0pWMGVBcXUxSVF5U0R6NjN0M1RIRlBr?=
 =?utf-8?B?eWVNbmZVRzMzVklnb1pVb0llbmdxSGxZTjYyMFZqMWo0R2dKdXNLSFp2d29q?=
 =?utf-8?B?bW5MSWpCVUJLRDNXZHNneURCRHVobXdvaVlwbHJZMVByeitndjdqSElKS2FY?=
 =?utf-8?B?R0UwcmNIV2dqZCtWbzN0YnRzcWM2V3lXOFlvbmJ4RmhKZE9vUzloOWp3NTBK?=
 =?utf-8?B?ZXFxTE9nSHdTRkN0UmVKWjdiRnIwaHo2S0xEMTZ0U3lLZVZEU2pVNm50eDZW?=
 =?utf-8?B?NjgxVWp1MWQ1blY5TGE5aE5jL1pRMEMwMnB1VzRzMDdzQ3prZitOQWdDTlRk?=
 =?utf-8?B?Qk9WOXJ5bG0rTXVORHhvUVZFWGF4UU0zanV1ZjZ1bGF1aUVMUlZ5TFBCbWMv?=
 =?utf-8?B?ZEVSRG9UODZ4eTRlWkdFcFYvR2R3L1FoOFlheitlc1VKeVR1SzNoNld6VUVk?=
 =?utf-8?B?NTd4NEdIelIzSlhUeitKTlpvUTZxUXBFMXgzazQzMlViTHBWeHI1eE40OUV0?=
 =?utf-8?B?T3pBMkRaYlRnVGlBSHdBQ0o4a0JjTGswSllQZjVVVEV0bGRkdTlnWnh5RVJO?=
 =?utf-8?B?emRJbVUwLy9WQmVVUndsN1hzWXlIZDV2VzY0WTB5aWxGZGxTUm5hZHl6bmRp?=
 =?utf-8?B?ckF2ajB3MG5COGhoSlR6dlVVVUdMQ3kxY1I4aGNIZFEzenRaZHNDQmdQdmo0?=
 =?utf-8?B?dnJGRS9LU0dFeUtuZUNRWXY3NnYySnV5T0d0VktLQStPVGZrWHdlMWNvN0dO?=
 =?utf-8?B?QnB1RDJPVFRlQ0MxTHpGU3pqWEdtNlRWRmJ2TjlvVVpJaFZRd1FFNUY0Z1do?=
 =?utf-8?B?eGZpVndnWVlGeUl4OU5SN0duYmxYNzA4VFkrRTFFMXAvU09SaXIrOTBJTStW?=
 =?utf-8?B?WjRzeTJZMUJtV0phdDREWno4YlkwWC9OR0RmcGkvcUdtMXhaaDFMeDF0SGV1?=
 =?utf-8?B?dnJ2VmM4MmpIQ3NCS3llY1FGRXBHYnlaaE0yZ1NwSDlVb1hkMytRd2l4K0wr?=
 =?utf-8?B?djJ5NjdOQnF3aG1SZmlKaHJqZ3NOdTNlVmxkV1I4QmZFTDE3WTFjMGxqQU5u?=
 =?utf-8?B?aXdCM1J3VzBYeUtXMVd5TlUrVGRoT3FHeE02ZVRvWWNwQzBDaEk1bkRoQ1pS?=
 =?utf-8?B?NG1idmNxejBheGFMdEpYMGpkWWhaTEJoTGljcUllcE40aCtMa1JneFJDelU1?=
 =?utf-8?Q?7V0CIUorqyi0EmsYnLQfDiPrx?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D618F304F606B342A19D31E1A7D5A561@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7040015e-e215-434b-731c-08dc7b983e09
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2024 02:21:38.5684
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cJh2dLD0h0DzRc8jRhvFs4TgA/w6EF+QBqvidT1zq+2uzsIVjYPU7pjfxyL05EedR3T5WaJuSU4boIa01DTMrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR03MB8059

T24gVGh1LCAyMDI0LTA1LTIzIGF0IDE0OjQ5ICswMjAwLCBBbGV4YW5kcmUgTWVyZ25hdCB3cm90
ZToNCj4gIAkgDQo+IEV4dGVybmFsIGVtYWlsIDogUGxlYXNlIGRvIG5vdCBjbGljayBsaW5rcyBv
ciBvcGVuIGF0dGFjaG1lbnRzIHVudGlsIHlvdSBoYXZlIHZlcmlmaWVkIHRoZSBzZW5kZXIgb3Ig
dGhlIGNvbnRlbnQuDQo+ICBEb2N1bWVudCB0aGUgZGlzcGxheSBBZGFwdGl2ZSBBbWJpZW50IExp
Z2h0IG9uIE1UODM2NSwgd2hpY2ggaXMgY29tcGF0aWJsZQ0KPiB3aXRoIHRoYXQgb2YgdGhlIE1U
ODE4My4NCg0KUmV2aWV3ZWQtYnk6IENLIEh1IDxjay5odUBtZWRpYXRlay5jb20+DQoNCj4gDQo+
IFJldmlld2VkLWJ5OiBBbmdlbG9HaW9hY2NoaW5vIERlbCBSZWdubyA8YW5nZWxvZ2lvYWNjaGlu
by5kZWxyZWdub0Bjb2xsYWJvcmEuY29tPg0KPiBBY2tlZC1ieTogUm9iIEhlcnJpbmcgKEFybSkg
PHJvYmhAa2VybmVsLm9yZz4NCj4gU2lnbmVkLW9mZi1ieTogQWxleGFuZHJlIE1lcmduYXQgPGFt
ZXJnbmF0QGJheWxpYnJlLmNvbT4NCj4gLS0tDQo+ICBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUv
YmluZGluZ3MvZGlzcGxheS9tZWRpYXRlay9tZWRpYXRlayxhYWwueWFtbCB8IDEgKw0KPiAgMSBm
aWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRh
dGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Rpc3BsYXkvbWVkaWF0ZWsvbWVkaWF0ZWssYWFsLnlh
bWwgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvZGlzcGxheS9tZWRpYXRlay9t
ZWRpYXRlayxhYWwueWFtbA0KPiBpbmRleCA2MjNjZjdlMzdmZTMuLjQ3ZGRiYTVjNDFhZiAxMDA2
NDQNCj4gLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Rpc3BsYXkvbWVk
aWF0ZWsvbWVkaWF0ZWssYWFsLnlhbWwNCj4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVl
L2JpbmRpbmdzL2Rpc3BsYXkvbWVkaWF0ZWsvbWVkaWF0ZWssYWFsLnlhbWwNCj4gQEAgLTM2LDYg
KzM2LDcgQEAgcHJvcGVydGllczoNCj4gICAgICAgICAgICAgICAgLSBtZWRpYXRlayxtdDgxODgt
ZGlzcC1hYWwNCj4gICAgICAgICAgICAgICAgLSBtZWRpYXRlayxtdDgxOTItZGlzcC1hYWwNCj4g
ICAgICAgICAgICAgICAgLSBtZWRpYXRlayxtdDgxOTUtZGlzcC1hYWwNCj4gKyAgICAgICAgICAg
ICAgLSBtZWRpYXRlayxtdDgzNjUtZGlzcC1hYWwNCj4gICAgICAgICAgICAtIGNvbnN0OiBtZWRp
YXRlayxtdDgxODMtZGlzcC1hYWwNCj4gIA0KPiAgICByZWc6DQo+IA0KPiAtLSANCj4gMi4yNS4x
DQo+IA0K

