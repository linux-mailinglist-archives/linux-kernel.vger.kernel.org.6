Return-Path: <linux-kernel+bounces-174169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 385BE8C0B16
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 07:42:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C8861C22D03
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 05:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 697C61494AB;
	Thu,  9 May 2024 05:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="bDio98up";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="VES7ZalB"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81E71C13C;
	Thu,  9 May 2024 05:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715233357; cv=fail; b=NuAeQBPQVcHhCzo2uwmqevwyM7GrIIFNkyPxWkQ56UBQ01bhYZtxxwPNwdDVTJRBoRz1FOkCYMg8b36z/na1Que6TbxPryFXbYPH+F5hdxExWNgIXA7w0pIXdw7OqCZ1b/KbyonwUCSXPixab5OQr90M4UJMQ2Lvg6fMk4HYvAk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715233357; c=relaxed/simple;
	bh=4gr8qYuulhW8UeiiQNJ00tmN8ZPPt2tSa3ob6D1vUUc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=apW1KRUPepdLFK6GlTDieVsM6O78uDMx7//sxc4wgiPlG80H2HnF8Rs9/q/5QVtrXcg2A9CMUe/cN9BqL8TE3hQLTf2Pv0sJ+NzD5u8iECs2zYHi910JpwcyFGFhMbQZPdm2y++wocWOIec2LuTXV5XfkBD9ZnBq9Or7VMKIyP8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=bDio98up; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=VES7ZalB; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: eaf8c7da0dc611efb92737409a0e9459-20240509
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=4gr8qYuulhW8UeiiQNJ00tmN8ZPPt2tSa3ob6D1vUUc=;
	b=bDio98up62R15GY85788+PnU1MUCmojJNToxL6y4co2vzDKgFNk3P9Jc0ZDo7YSHmYNmwjBLwz8HVajER4/DnhEq2Oqq0hSkYDQIIwKa9O8Al48HSfGlFqcVez93QEp3j0fAvbAnU8Il4SBiJ9TTMXEgwpaviL1OKWMtnpNHbQA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:1b9c96c1-ac85-454b-b4cd-734ca5a577ed,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:82c5f88,CLOUDID:beb98992-e2c0-40b0-a8fe-7c7e47299109,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: eaf8c7da0dc611efb92737409a0e9459-20240509
Received: from mtkmbs09n2.mediatek.inc [(172.21.101.94)] by mailgw01.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 821435909; Thu, 09 May 2024 13:42:26 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 9 May 2024 13:42:24 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 9 May 2024 13:42:24 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DyPNIhCCsgwo2Ggrj8s8ncnBuSMbasFCPoag1kCUQGE10Mz2ej+pMhRLq/XCF5HupFRQ3CUk871X81rTcDtfM9tkj0TNNj5bWhb5DzBRptI3sO0p9rGBmwk0NByMplXDYBoyVj/zNJOEdIp4F5kjhubEGjlH+g7dFs0Fd39R+NqmTRDTr+Q0mopo2e43moKrVOsx6yIzNmFTCNKCm/854oqFnX9/CrM8aF33uqw9Syz6uwoqLWvwAqiwib1L+c+F1W9/JOtZQTCG73s8rlnfoBbNa1F0dL7tnfzoMCtgOp+t+rD2SJy9mNgYEaaiHbZlMlp42rRnX+FzJSM9FPQsqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4gr8qYuulhW8UeiiQNJ00tmN8ZPPt2tSa3ob6D1vUUc=;
 b=MCZLi5aeODDv6RboCnjp7L28tX3nSQK49yrmHp/JYE/5kdJcSguCGLVY1LEFxA9cj/kj3NGs0ICJrL/TbJOkeEQEbS1lSnaN4jtGpEjB48gvyGAs/I+mrGErkgHrV/FqGWK3en5znj7hhvQKAmyvB1vyoL2DZD4UJG7VeHG53xT/HfzCMgZrc1WBg/9RPfDIlk9B+nYEXWPbnZObdlDYbrfMm6zImZGLpfDJghmWjz5gP7IzVX6hKF4/lkZCO7pvipAKLq26FHtuvnBR1yntrFK8/1T3443DmbAhUNwHBLjstU+cyfOTBBW14NofT4WVmUCsn/UnDzF/XwLs/UFmvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4gr8qYuulhW8UeiiQNJ00tmN8ZPPt2tSa3ob6D1vUUc=;
 b=VES7ZalB7uROxTyTYhEyXSX5yanIBLjdE+J7lBUOWmhivHc4tot2xTmGp1bg7r8ZZTj+yB4UfZjFcSi8wpQIvRcmbTbWZTMXzoy4aqIryXSiREJn3sgFUQ7dbaXsUBA8mPKJf33FvsX4Bs0lJa+wb9dGyfm6mFi2wQOu2oQTzOM=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by OSQPR03MB8554.apcprd03.prod.outlook.com (2603:1096:604:272::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.45; Thu, 9 May
 2024 05:42:21 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54%4]) with mapi id 15.20.7544.041; Thu, 9 May 2024
 05:42:21 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: "angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>, "chunkuang.hu@kernel.org"
	<chunkuang.hu@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"wenst@chromium.org" <wenst@chromium.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "tzimmermann@suse.de" <tzimmermann@suse.de>,
	=?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= <Shawn.Sung@mediatek.com>,
	"mripard@kernel.org" <mripard@kernel.org>,
	=?utf-8?B?Sml0YW8gU2hpICjnn7PorrDmtpsp?= <jitao.shi@mediatek.com>,
	"daniel@ffwll.ch" <daniel@ffwll.ch>, "p.zabel@pengutronix.de"
	<p.zabel@pengutronix.de>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>,
	"robh@kernel.org" <robh@kernel.org>, "dri-devel@lists.freedesktop.org"
	<dri-devel@lists.freedesktop.org>, "airlied@gmail.com" <airlied@gmail.com>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"kernel@collabora.com" <kernel@collabora.com>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, =?utf-8?B?WXUtY2hhbmcgTGVlICjmnY7nprnnkosp?=
	<Yu-chang.Lee@mediatek.com>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 2/3] dt-bindings: arm: mediatek: mmsys: Add OF graph
 support for board path
Thread-Topic: [PATCH v2 2/3] dt-bindings: arm: mediatek: mmsys: Add OF graph
 support for board path
Thread-Index: AQHainXPkoeeapgKhkmHjjX1T7SS9LF4WlSAgAtsa4CAB7xpgIAAd5qAgAEgaYCAAGApgIABFxEA
Date: Thu, 9 May 2024 05:42:21 +0000
Message-ID: <ee721fd3339f8b3a25464ca57ca192343a51e514.camel@mediatek.com>
References: <20240409120211.321153-1-angelogioacchino.delregno@collabora.com>
	 <20240409120211.321153-3-angelogioacchino.delregno@collabora.com>
	 <aa7e3bcf70383e563a65919f924ec2e5e4cd778c.camel@mediatek.com>
	 <becdc2e5-4a1d-4280-b6f8-78d4903be283@collabora.com>
	 <4dfb09b9c437ab2baa0898eca13a43fd7475047a.camel@mediatek.com>
	 <46347f5d-e09b-4e83-a5a2-e12407f442a4@collabora.com>
	 <847e1a84b532956f697d24014d684c86f0b76f03.camel@mediatek.com>
	 <cbf73111-a6cf-47da-9563-89d49fbdb17d@collabora.com>
In-Reply-To: <cbf73111-a6cf-47da-9563-89d49fbdb17d@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|OSQPR03MB8554:EE_
x-ms-office365-filtering-correlation-id: 35d52e58-7b8e-47d7-599a-08dc6feacbc2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|366007|7416005|1800799015|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?Vzlid0xEaXJJUHY2c1hreE1OZzFFOHh5WGQreGFHZWNxM2o4SlJjbmVFV091?=
 =?utf-8?B?eHppUW45T1M5Qnkrdk1NcWR1YU1xald2U0pBU2Uva3lkTHBoM2IyNnVTcVhJ?=
 =?utf-8?B?U3p4R2dlejVBMFlmdUJVYW02aHFUSXdDc1BabjBSMXhBYWZnY1BFT0tsdk9p?=
 =?utf-8?B?MGl1K3RFMFYzSHNxOXNITWE0c0xCRE83MzlETGQvdEpVU2VEREVlL0x4TFNo?=
 =?utf-8?B?WjhoMzBveFlsVEZrUWZvKzh5VXdvM3J1WTVIUDlVVEE3YW8wSzVOdEUyR2U4?=
 =?utf-8?B?b0o4Ynl4OFcwdkpwc1VqMDA0ZWJsbk8zVkp1ZWxkVVFyMGxBc0dZV29uWExo?=
 =?utf-8?B?ZmRHc0YyVzJKT0x0TmljV2g3ZFJPT0FqVDIvOTA1cFR0bTRPMWZkTnBodWp2?=
 =?utf-8?B?K0RaTGYrd2NKdGhhY0FlVHk2cmxDbldnNGxnVEkwNDFYWjZ1NFpvbE81aEQr?=
 =?utf-8?B?aTg3QkRYak9IQzNBMXUwZ1V4c3JzWTZaclRhZHRIRmRVcXdDbmlaREsydU0x?=
 =?utf-8?B?bEVHdDF0SWJSbjFFMys3cjFPc0JkTFBzYzBZZUpjWlFXZUZrQ3k0Y0pFeDZ6?=
 =?utf-8?B?NXF6eDlzYktDSEZHeTR5UGMxM1hIM0Q5WVp2WnNsdHp2eUZxanhLdnozWXZh?=
 =?utf-8?B?U3UwcFU3Ym5zaEo4dGhwd3lQdUcwTWEzWXRvcm9OVllhZENzT1c4NVdtRmNS?=
 =?utf-8?B?UVFvcW1zQkxVeGZqS3U0S2w2MWU4VWtUVWZCbWEzeHNtUWd0bDJJcmw0M3VK?=
 =?utf-8?B?dkcwdzlDMW1TVFBvM01DODdwZDRPekN5ZXlhTldHem9ydzlkVlFsZExTTkNl?=
 =?utf-8?B?b1R0NE9mMGthVFpicFFXbllSOUxKT2VwaDNhSDhrdGlpc1oxOENONWswTVpV?=
 =?utf-8?B?M2cvOFRZeFJmV1JxcDBYbXBHQUx4VnBoclVuUWlzV3UyeWkvUjhqMGhDSkor?=
 =?utf-8?B?WlVrR0I3S05PaHI4Ty9lOE5nOXVFeERvYW5PT3U2Y2N0UWw1c0prTE5JYU51?=
 =?utf-8?B?TWxuYkRNUm1EWmxlU2xRdEFseUt3M0w2bDcwdzM5UlBUdTJsL2FBTStDcnZG?=
 =?utf-8?B?RTVEMndhYTF2MWZTdXE4RGxSQ0EzdFVFM3J3OEppb3hvR1BhdXBmdzF4UnRt?=
 =?utf-8?B?UzN0OHhHNno3bnBCaXBBRHk3ZFBYcnhZWWIwNERPUWdvS1VvUzdaamN5bUJ2?=
 =?utf-8?B?NTZGdEN5eFVGbnJGb2x1SHhVb0UvYkdpWDBsUmhWdzF6VXdtS2EyTU40VHFM?=
 =?utf-8?B?MytnZVlsZzI1elVrVGllTmRYdGZ1SHpudnBHK0tYdk8vbHZBS2JKV0FrdGVS?=
 =?utf-8?B?N0dXeVFtU1AvUFFtMmE0SVg2eHU5SjMyWjh3SFFLVldxWGFab3RLVzByWjZP?=
 =?utf-8?B?TnR3ZE52YVN6WjNIS25sK0ZrK2RoeThvemQ2MjZGS3VnU2ZDbWpGT05tTEFh?=
 =?utf-8?B?RUxZNVlNeUJwRHBJaHZtM1FxWmtBbHBJc2hEVmxMMXZBUWd2WVUwdkg0WmVC?=
 =?utf-8?B?aVhkWFg3QU1XVVpkRVV2YlhKYlFabTBTVzVPTzFkU0ZEY3BiUDBpSTJrdWxt?=
 =?utf-8?B?disrRFVYUlFDNEVnK2JYNitFUnVKeFdYRnlBeHl2VmZmTHJWMmxEbnVFamNu?=
 =?utf-8?B?NitpQ01VcDQ1ekZuQkZOeE5PUmNJbWFKOW9TV2VzOGZHN3ZMVlJFWVNyZXFM?=
 =?utf-8?B?QlZaek82eVFEYXhwVlVlSkltci9SVnhSTFNQNXR1dTlCYy9RVFJOdDNaNWU2?=
 =?utf-8?B?SzBhTnZScDVuS2htdDVQWnZPbDlDdUdIQkU0UlY3K3pXVjNQY0tiKzIyN3Fh?=
 =?utf-8?B?Z2YxdDlYUEluUVJaQkZNQT09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(7416005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y09CYlphUVJBZkxaQ3V1VlJjZnE0T1hkSkhkOC9YM0ZwdFJva0xySHFyYm0w?=
 =?utf-8?B?MkNpMGg4bzZwWXNkRFk0bDJQVTVhc2hlR2NxSWcvT1REYUp4ckhDSVRXelBl?=
 =?utf-8?B?bjBCcHhZMEM1SHY3Y0U0MW9ZaXp6cG83M05jaE50S2paVDZ1YnF3d1hWeVNP?=
 =?utf-8?B?cjJjRmRlRytNTnVNZGxxRXZWbDJvenU2VGxuUS9HeU8rUDVJYWQ5OXRlQ0Rn?=
 =?utf-8?B?T3d3YWxkL2lTWStqazVaemZpUnhYOUVDTHE1aVZ3MFdxMUxNTHQvd21XZXVp?=
 =?utf-8?B?SjJpRmtYQzRLcUc0eUl3UndXRGpLZVEyRGpWUEt3VWhDam9LVlJJdDNGV2dX?=
 =?utf-8?B?YlFORndTcnAzWXpNdUE0d1VaMnVOQk9aak8ycklnSEsvd2Nqd2s5WnlNZmFQ?=
 =?utf-8?B?N3NSNDByaXBWYzdqU05IVHZKQXFvVmVSelJxRmxJYngzL295TmhiMmlFcDl3?=
 =?utf-8?B?Mnd4U2I3OHEyWjNsZ0VkQ2RIUXMyQ0FOMEdXcDREUm5LR1Y1Vm1hT0xWWFZD?=
 =?utf-8?B?c3RIcTRqMVA2WDhhalhtTVV3Y0VHY0UyZXVKb1ZObzVzN0V6cHBWWml4d0VS?=
 =?utf-8?B?YW5GeU1iOTlNODcwLzhGSFc0aGVUdkI5blBQL1I1RDdQWWVnLzdYeDB2U0dz?=
 =?utf-8?B?NmdKZmZjNFBYcTlxRmg1U2tKY2hoeGx3WXBodzRYb0lTRnlsSU5laVZrK0ZD?=
 =?utf-8?B?NWR3RExrNy8zaSsxaTZUbFBIck1zdmlVTWYwTnZlc2lRYmRRUVdxaGVZMmFo?=
 =?utf-8?B?MFdhMWdPNzJYbzZsTmNMUGdkdWd4dlhFZHBDQzJSMmlBNXlmWEJWS3BadjdI?=
 =?utf-8?B?YlVLSkFaK2lnVlFrYzJjMnU2dzhUcWhKS3ZNK0hsMFFBY3g0TGRZR3o3V05i?=
 =?utf-8?B?Yksvc3lORkl6RWVvTEhSVFhXQXRWbDRvN2E0NUpMM25ZMEJWUGxCN1NhbTV1?=
 =?utf-8?B?bzJRQ3FiS0hLQnhlMnZ0dmJLRGZzemFFZjRBQ1pUYW9rRXlYb1hVMTY4QlNC?=
 =?utf-8?B?RERLZUZ0ZHQ0Tm5aSnI0bmV3aFhJWXRaeWpoZmhoWWw4SnVSMW5NWm8rQ1Vr?=
 =?utf-8?B?T0dycUJRZlhnbE84T0JOM3pCUDNsOUFOSmFxU3F0cmJEWTN0cy9aTUx4b2Z0?=
 =?utf-8?B?SWZSMnlEaWVNTXVzZ24xQ0dXTmxTUFU3NTJhZC9CYmtPczBsS292YTlZS3V1?=
 =?utf-8?B?aFdGTi9nSFRoempON3lJUE5lSXNITHBxa0FxaS9RQ1Y1Rm5NVzI0MEZOQjl5?=
 =?utf-8?B?YTJsUGtXZFppK1YxV2pNb25JR0xIZDV1SWVkTk55WjRQeTRuM3pvWjZQZ2h4?=
 =?utf-8?B?Z3cwRzVZS01nbTVhZ3piV24yWXd4a2xLTEt2cHJXT1lnWU9idzZTZHU2TW5r?=
 =?utf-8?B?L1lBdlVvSE5EaFdGZThzLytIcmdCZENqVTVSbnI4SXNGbmhyR2lWbVgyM2lC?=
 =?utf-8?B?N3JmSHFxdjZoeG5DNTZMZVRPN240VEgzcXF6Y2RQSzdYMDhFRkJ4WmFYbWtQ?=
 =?utf-8?B?Y2F0QzdXaVNwYnBNTkdvayt4VXd6OWtsdU9NVEZ1QzZHS2hpVlljRkR0Snll?=
 =?utf-8?B?eUN5TjRXZFF5R1ZMdFhTRFB1UzdXZTZyOTcxYXE3Ni8xaGtNVHp2Y1JsczZJ?=
 =?utf-8?B?WmkzWnFHd0h3dE92bE5JRTVoM3ZwSndUeGRZSUFZbU52enhkYjUvMS9tejlF?=
 =?utf-8?B?Vnl1TmEwMmxsT2xJZlMrNzJGMHpiMUxxcTZtempTMEZzNXlRUytkeURrczFh?=
 =?utf-8?B?Z0hKdGs5ZzBqVGxaZlI1N0ZyYll6TEg2VndUeHJ2SmFBcDdLT2FBcWg0VHUy?=
 =?utf-8?B?L1AxQ2dRait2bDFseVZrR0lyUjQzc2hNSFN0VlEvSHZyNGdWT3Y4enRKeXJQ?=
 =?utf-8?B?dTJrUmFPZDgwZjBtRE1YNUYvL2NPbWJHMWc2U09WSnBqeHM3cVpQTmVnTlpF?=
 =?utf-8?B?eElXenZ0TG4xa1dFVytQOUZ2MkNnNmU3UEJEYmxnMEhnWHJRVVQ0c1JieXR6?=
 =?utf-8?B?aWt0bEwwVGhMVVdvNmVieHIzOHNpNWROUWk2cFI1QmkzdFpMRnMxU0NTMlNr?=
 =?utf-8?B?N0ZvakVOREdPdXMwR09VekxWaVF5YVBSZ2tkOXIvQWhhOWZ5d0U5bXJWZW5q?=
 =?utf-8?Q?KpT6Djh4IYlH/ZQiKOg8mMtzq?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DABE0A1B18CDD747B86D3F20DD02D17A@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35d52e58-7b8e-47d7-599a-08dc6feacbc2
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2024 05:42:21.0846
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j74E8kwZYRVzUIqjZsU/ROsXJ5CHO2szoFrv8wO11jDyJdFIjcI/K6oZOQ4gd7HdLl4RHTBCNkQgAcJwQ6DI1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSQPR03MB8554
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--24.850000-8.000000
X-TMASE-MatchedRID: Ync95tbzDRkNtKv7cnNXnSa1MaKuob8PofZV/2Xa0cJauByPtDznddP8
	W0t/rMaUuF0hjaCRm7eXlSuRSjjgAR2P280ZiGmRdARARTk4h58g0UhtlIhR0bw2tvOM+/Mn/3I
	kNzIvYoOnQFe+ESmb0znK6vsLfhdIvRezSnFjJZXRc75iroKqAjGZtPrBBPZrfmHrLgoJIlyWgG
	h40SiSOMRM8R9ToUYStPY82M+A1uw2DJ6UHhjHQjiPEKUh+xB+KVrLOZD1BXREPdNmmPe2oPMrt
	sTYdEzg81lPkV83tGsIjTclREIPflI3mP8aC0PB9Ib/6w+1lWS6QCTCuzfiVdr4gfya+A9UA6Oq
	jdGfjicvNgy8MD0IfXKedVMauy+rDkYiOjmaAHaRfvUfL+585t9InWSoxyrB+Cckfm+bb6AD2qM
	jSvib9wa5KOJY8aPdFBANMkj9p/xZT98H9cWYnIv73wEu0Nx79CFB7klVg4fagsZM0qVv13rgVH
	QadHXfGVJKX1PcTXeJ2TXXu8lGapG468S7yeiwCFaAixm5eU+fM+smQZqWkI9osn8JrdJPQlw4O
	8X7MZyNOgGT75p32Hk41aRgHEZlgFWhWut0cL2Swdo9pBBGwCDQvhfLY4eVLzNBnatH86n7vKTV
	SA2nFAvAOiOADplSpJ+tbbRqiA3DkHnJwIRKW7E3FpMbg63SzW2aB1gHHZNJg8sTT3RzF62Ikln
	66mYTGNw1vcIXdf+ptheW5g7GtCt3K4bk+zaTngIgpj8eDcDBa6VG2+9jFNQdB5NUNSsiR7QbH+
	f1FyVm8n7jDidmdd0H8LFZNFG7JQhrLH5KSJ0=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--24.850000-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	14F3DFF999CB073D563BE72FFC09B265E29F19C3705A72909A460C00529FE5102000:8

T24gV2VkLCAyMDI0LTA1LTA4IGF0IDE1OjAzICswMjAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gSWwgMDgvMDUvMjQgMDk6MTksIENLIEh1ICjog6Hkv4rlhYkpIGhhIHNj
cml0dG86DQo+ID4gT24gVHVlLCAyMDI0LTA1LTA3IGF0IDE2OjA3ICswMjAwLCBBbmdlbG9HaW9h
Y2NoaW5vIERlbCBSZWdubw0KPiA+IHdyb3RlOg0KPiA+ID4gSWwgMDcvMDUvMjQgMDg6NTksIENL
IEh1ICjog6Hkv4rlhYkpIGhhIHNjcml0dG86DQo+ID4gPiA+IE9uIFRodSwgMjAyNC0wNS0wMiBh
dCAxMDo1MCArMDIwMCwgQW5nZWxvR2lvYWNjaGlubyBEZWwgUmVnbm8NCj4gPiA+ID4gd3JvdGU6
DQo+ID4gPiA+ID4gSWwgMjUvMDQvMjQgMDQ6MjMsIENLIEh1ICjog6Hkv4rlhYkpIGhhIHNjcml0
dG86DQo+ID4gPiA+ID4gPiBIaSwgQW5nZWxvOg0KPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiBP
biBUdWUsIDIwMjQtMDQtMDkgYXQgMTQ6MDIgKzAyMDAsIEFuZ2Vsb0dpb2FjY2hpbm8gRGVsDQo+
ID4gPiA+ID4gPiBSZWdubw0KPiA+ID4gPiA+ID4gd3JvdGU6DQo+ID4gPiA+ID4gPiA+IERvY3Vt
ZW50IE9GIGdyYXBoIG9uIE1NU1lTL1ZET1NZUzogdGhpcyBzdXBwb3J0cyB1cCB0bw0KPiA+ID4g
PiA+ID4gPiB0aHJlZQ0KPiA+ID4gPiA+ID4gPiBERFANCj4gPiA+ID4gPiA+ID4gcGF0aHMNCj4g
PiA+ID4gPiA+ID4gcGVyIEhXIGluc3RhbmNlIChzbyBwb3RlbnRpYWxseSB1cCB0byBzaXggZGlz
cGxheXMgZm9yDQo+ID4gPiA+ID4gPiA+IG11bHRpLQ0KPiA+ID4gPiA+ID4gPiB2ZG8NCj4gPiA+
ID4gPiA+ID4gU29DcykuDQo+ID4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gPiBUaGUgTU1TWVMg
b3IgVkRPU1lTIGlzIGFsd2F5cyB0aGUgZmlyc3QgY29tcG9uZW50IGluIHRoZQ0KPiA+ID4gPiA+
ID4gPiBERFANCj4gPiA+ID4gPiA+ID4gcGlwZWxpbmUsDQo+ID4gPiA+ID4gPiA+IHNvIGl0IG9u
bHkgc3VwcG9ydHMgYW4gb3V0cHV0IHBvcnQgd2l0aCBtdWx0aXBsZQ0KPiA+ID4gPiA+ID4gPiBl
bmRwb2ludHMgLQ0KPiA+ID4gPiA+ID4gPiB3aGVyZQ0KPiA+ID4gPiA+ID4gPiBlYWNoDQo+ID4g
PiA+ID4gPiA+IGVuZHBvaW50IGRlZmluZXMgdGhlIHN0YXJ0aW5nIHBvaW50IGZvciBvbmUgb2Yg
dGhlDQo+ID4gPiA+ID4gPiA+IChjdXJyZW50bHkNCj4gPiA+ID4gPiA+ID4gdGhyZWUpDQo+ID4g
PiA+ID4gPiA+IHBvc3NpYmxlIGhhcmR3YXJlIHBhdGhzLg0KPiA+ID4gPiA+ID4gPiANCj4gPiA+
ID4gPiA+ID4gU2lnbmVkLW9mZi1ieTogQW5nZWxvR2lvYWNjaGlubyBEZWwgUmVnbm8gPA0KPiA+
ID4gPiA+ID4gPiBhbmdlbG9naW9hY2NoaW5vLmRlbHJlZ25vQGNvbGxhYm9yYS5jb20+DQo+ID4g
PiA+ID4gPiA+IC0tLQ0KPiA+ID4gPiA+ID4gPiAgICAgLi4uL2JpbmRpbmdzL2FybS9tZWRpYXRl
ay9tZWRpYXRlayxtbXN5cy55YW1sIHwgMjMNCj4gPiA+ID4gPiA+ID4gKysrKysrKysrKysrKysr
KysrKw0KPiA+ID4gPiA+ID4gPiAgICAgMSBmaWxlIGNoYW5nZWQsIDIzIGluc2VydGlvbnMoKykN
Cj4gPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiA+IGRpZmYgLS1naXQNCj4gPiA+ID4gPiA+ID4g
YS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvYXJtL21lZGlhdGVrL21lZGlhdGVr
DQo+ID4gPiA+ID4gPiA+ICxtbXMNCj4gPiA+ID4gPiA+ID4geXMueQ0KPiA+ID4gPiA+ID4gPiBh
bWwNCj4gPiA+ID4gPiA+ID4gYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvYXJt
L21lZGlhdGVrL21lZGlhdGVrDQo+ID4gPiA+ID4gPiA+ICxtbXMNCj4gPiA+ID4gPiA+ID4geXMu
eQ0KPiA+ID4gPiA+ID4gPiBhbWwNCj4gPiA+ID4gPiA+ID4gaW5kZXggYjNjNjg4OGMxNDU3Li40
ZTlhY2Q5NjZhYTUgMTAwNjQ0DQo+ID4gPiA+ID4gPiA+IC0tLQ0KPiA+ID4gPiA+ID4gPiBhL0Rv
Y3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vbWVkaWF0ZWsvbWVkaWF0ZWsNCj4g
PiA+ID4gPiA+ID4gLG1tcw0KPiA+ID4gPiA+ID4gPiB5cy55DQo+ID4gPiA+ID4gPiA+IGFtbA0K
PiA+ID4gPiA+ID4gPiArKysNCj4gPiA+ID4gPiA+ID4gYi9Eb2N1bWVudGF0aW9uL2RldmljZXRy
ZWUvYmluZGluZ3MvYXJtL21lZGlhdGVrL21lZGlhdGVrDQo+ID4gPiA+ID4gPiA+ICxtbXMNCj4g
PiA+ID4gPiA+ID4geXMueQ0KPiA+ID4gPiA+ID4gPiBhbWwNCj4gPiA+ID4gPiA+ID4gQEAgLTkz
LDYgKzkzLDI5IEBAIHByb3BlcnRpZXM6DQo+ID4gPiA+ID4gPiA+ICAgICAgICcjcmVzZXQtY2Vs
bHMnOg0KPiA+ID4gPiA+ID4gPiAgICAgICAgIGNvbnN0OiAxDQo+ID4gPiA+ID4gPiA+ICAgICAN
Cj4gPiA+ID4gPiA+ID4gKyAgcG9ydDoNCj4gPiA+ID4gPiA+ID4gKyAgICAkcmVmOiAvc2NoZW1h
cy9ncmFwaC55YW1sIy9wcm9wZXJ0aWVzL3BvcnQNCj4gPiA+ID4gPiA+ID4gKyAgICBkZXNjcmlw
dGlvbjoNCj4gPiA+ID4gPiA+ID4gKyAgICAgIE91dHB1dCBwb3J0IG5vZGUuIFRoaXMgcG9ydCBj
b25uZWN0cyB0aGUNCj4gPiA+ID4gPiA+ID4gTU1TWVMvVkRPU1lTDQo+ID4gPiA+ID4gPiA+IG91
dHB1dA0KPiA+ID4gPiA+ID4gPiB0bw0KPiA+ID4gPiA+ID4gPiArICAgICAgdGhlIGZpcnN0IGNv
bXBvbmVudCBvZiBvbmUgZGlzcGxheSBwaXBlbGluZSwgZm9yDQo+ID4gPiA+ID4gPiA+IGV4YW1w
bGUNCj4gPiA+ID4gPiA+ID4gb25lDQo+ID4gPiA+ID4gPiA+IG9mDQo+ID4gPiA+ID4gPiA+ICsg
ICAgICB0aGUgYXZhaWxhYmxlIE9WTCBvciBSRE1BIGJsb2Nrcy4NCj4gPiA+ID4gPiA+ID4gKyAg
ICAgIFNvbWUgTWVkaWFUZWsgU29DcyBzdXBwb3J0IHVwIHRvIHRocmVlIGRpc3BsYXkNCj4gPiA+
ID4gPiA+ID4gb3V0cHV0cw0KPiA+ID4gPiA+ID4gPiBwZXINCj4gPiA+ID4gPiA+ID4gTU1TWVMu
DQo+ID4gPiA+ID4gPiA+ICsgICAgcHJvcGVydGllczoNCj4gPiA+ID4gPiA+ID4gKyAgICAgIGVu
ZHBvaW50QDA6DQo+ID4gPiA+ID4gPiA+ICsgICAgICAgICRyZWY6IC9zY2hlbWFzL2dyYXBoLnlh
bWwjL3Byb3BlcnRpZXMvZW5kcG9pbnQNCj4gPiA+ID4gPiA+ID4gKyAgICAgICAgZGVzY3JpcHRp
b246IE91dHB1dCB0byB0aGUgcHJpbWFyeSBkaXNwbGF5DQo+ID4gPiA+ID4gPiA+IHBpcGVsaW5l
DQo+ID4gPiA+ID4gPiA+ICsNCj4gPiA+ID4gPiA+ID4gKyAgICAgIGVuZHBvaW50QDE6DQo+ID4g
PiA+ID4gPiA+ICsgICAgICAgICRyZWY6IC9zY2hlbWFzL2dyYXBoLnlhbWwjL3Byb3BlcnRpZXMv
ZW5kcG9pbnQNCj4gPiA+ID4gPiA+ID4gKyAgICAgICAgZGVzY3JpcHRpb246IE91dHB1dCB0byB0
aGUgc2Vjb25kYXJ5IGRpc3BsYXkNCj4gPiA+ID4gPiA+ID4gcGlwZWxpbmUNCj4gPiA+ID4gPiA+
ID4gKw0KPiA+ID4gPiA+ID4gPiArICAgICAgZW5kcG9pbnRAMjoNCj4gPiA+ID4gPiA+ID4gKyAg
ICAgICAgJHJlZjogL3NjaGVtYXMvZ3JhcGgueWFtbCMvcHJvcGVydGllcy9lbmRwb2ludA0KPiA+
ID4gPiA+ID4gPiArICAgICAgICBkZXNjcmlwdGlvbjogT3V0cHV0IHRvIHRoZSB0ZXJ0aWFyeSBk
aXNwbGF5DQo+ID4gPiA+ID4gPiA+IHBpcGVsaW5lDQo+ID4gPiA+ID4gPiA+ICsNCj4gPiA+ID4g
PiA+ID4gKyAgICByZXF1aXJlZDoNCj4gPiA+ID4gPiA+ID4gKyAgICAgIC0gZW5kcG9pbnRAMA0K
PiA+ID4gPiA+ID4gPiArDQo+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+IG1tc3lzL3Zkb3N5cyBk
b2VzIG5vdCBvdXRwdXQgZGF0YSB0byB0aGUgZmlyc3QgY29tcG9uZW50IG9mDQo+ID4gPiA+ID4g
PiBkaXNwbGF5DQo+ID4gPiA+ID4gPiBwaXBlbGluZSwgc28gdGhpcyBjb25uZWN0aW9uIGxvb2tz
ICd2aXJ0dWFsJy4gU2hhbGwgd2UgYWRkDQo+ID4gPiA+ID4gPiBzb21ldGhpbmcNCj4gPiA+ID4g
PiA+IHZpcnR1YWwgaW4gZGV2aWNlIHRyZWU/IFlvdSBhZGQgdGhpcyBpbiBvcmRlciB0byBkZWNp
ZGUNCj4gPiA+ID4gPiA+IHdoaWNoDQo+ID4gPiA+ID4gPiBwaXBlbGluZQ0KPiA+ID4gPiA+ID4g
aXMgMXN0LCAybmQsIDNyZCwgYnV0IGZvciBkZXZpY2UgaXQgZG9uJ3QgY2FyZSB3aGljaCBvbmUg
aXMNCj4gPiA+ID4gPiA+IGZpcnN0Lg0KPiA+ID4gPiA+ID4gSW4NCj4gPiA+ID4gPiA+IGNvbXB1
dGVyLCBzb2Z0d2FyZSBjb3VsZCBjaGFuZ2Ugd2hpY2ggZGlzcGxheSBpcyB0aGUNCj4gPiA+ID4g
PiA+IHByaW1hcnkNCj4gPiA+ID4gPiA+IGRpc3BsYXkuDQo+ID4gPiA+ID4gPiBJJ20gbm90IHN1
cmUgaXQncyBnb29kIHRvIGRlY2lkZSBkaXNwbGF5IG9yZGVyIGluIGRldmljZQ0KPiA+ID4gPiA+
ID4gdHJlZT8NCj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IERldmljZXRyZWUg
ZGVzY3JpYmVzIGhhcmR3YXJlLCBzbyBub3RoaW5nIHZpcnR1YWwgY2FuIGJlDQo+ID4gPiA+ID4g
cHJlc2VudA0KPiA+ID4gPiA+IC0NCj4gPiA+ID4gPiBhbmQgaW4gYW55IGNhc2UsDQo+ID4gPiA+
ID4gdGhlIHByaW1hcnkvc2Vjb25kYXJ5L3RlcnRpYXJ5IHBpcGVsaW5lIGlzIGluIHJlbGF0aW9u
IHRvDQo+ID4gPiA+ID4gTU0vVkRPDQo+ID4gPiA+ID4gU1lTLA0KPiA+ID4gPiA+IG5vdCByZWZl
cnJlZA0KPiA+ID4gPiA+IHRvIHNvZnR3YXJlLg0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IEJldHRl
ciBleHBsYWluaW5nLCB0aGUgcHJpbWFyeSBwaXBlbGluZSBpcyBub3QgbmVjZXNzYXJpbHkNCj4g
PiA+ID4gPiB0aGUNCj4gPiA+ID4gPiBwcmltYXJ5IGRpc3BsYXkgaW4NCj4gPiA+ID4gPiBEUk0g
dGVybXM6IHRoYXQncyBhIGNvbmNlcHQgdGhhdCBpcyBjb21wbGV0ZWx5IGRldGFjaGVkIGZyb20N
Cj4gPiA+ID4gPiB0aGUNCj4gPiA+ID4gPiBzY29wZSBvZiB0aGlzDQo+ID4gPiA+ID4gc2VyaWVz
IGFuZCB0aGlzIGdyYXBoIC0gYW5kIGl0J3Mgc29tZXRoaW5nIHRoYXQgc2hhbGwgYmUNCj4gPiA+
ID4gPiBtYW5hZ2VkDQo+ID4gPiA+ID4gc29sZWx5IGJ5IHRoZQ0KPiA+ID4gPiA+IGRyaXZlciAo
bWVkaWF0ZWstZHJtIGluIHRoaXMgY2FzZSkuDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gQ29taW5n
IGJhY2sgdG8gdGhlIGNvbm5lY3Rpb24gbG9va2luZywgYnV0ICpub3QqIGJlaW5nDQo+ID4gPiA+
ID4gdmlydHVhbDoNCj4gPiA+ID4gPiB0aGUNCj4gPiA+ID4gPiBzZW5zZSBoZXJlIGlzDQo+ID4g
PiA+ID4gdGhhdCB0aGUgTU0vVkRPU1lTIGJsb2NrcyBhcmUgdXNlZCBpbiB0aGUgZGlzcGxheSBw
aXBlbGluZSB0bw0KPiA+ID4gPiA+ICJzdGl0Y2giIHRvZ2V0aGVyDQo+ID4gPiA+ID4gdGhlIHZh
cmlvdXMgZGlzcGxheSBwaXBlbGluZSBoYXJkd2FyZSBibG9ja3MsIG9yLCBzYWlkDQo+ID4gPiA+
ID4gZGlmZmVyZW50bHksDQo+ID4gPiA+ID4gc2V0dGluZyB1cCB0aGUNCj4gPiA+ID4gPiByb3V0
aW5nIGJldHdlZW4gYWxsIG9mIHRob3NlIChQLlMuOg0KPiA+ID4gPiA+IG1tc3lzX210eHh4eF9y
b3V0aW5nX3RhYmxlISkNCj4gPiA+ID4gPiB0aHJvdWdoIHRoZSBWRE8NCj4gPiA+ID4gPiBJbnB1
dCBTZWxlY3Rpb24gKFZET3hfU0VMX0lOKSBvciBPdXRwdXQgU2VsZWN0aW9uDQo+ID4gPiA+ID4g
KFZET3hfU0VMX09VVCkNCj4gPiA+ID4gPiBhbmQNCj4gPiA+ID4gPiB3aXRoIHRoZQ0KPiA+ID4g
PiA+IGFzc2lzdGFuY2Ugb2YgdGhlIFZETyBNdWx0aXBsZSBPdXRwdXQgTWFzayAoVkRPeF9NT1VU
KSBmb3INCj4gPiA+ID4gPiB0aGUNCj4gPiA+ID4gPiBtdWx0aXBsZSBvdXRwdXRzDQo+ID4gPiA+
ID4gdXNlY2FzZSwgYm90aCBvZiB3aGljaCwgYXJlIGRlc2NyaWJlZCBieSB0aGlzIGdyYXBoLg0K
PiA+ID4gPiANCj4gPiA+ID4gSSBhZ3JlZSB0aGlzIHBhcnQsIGJ1dCB0aGlzIGlzIHJlbGF0ZWQg
dG8gZGlzcGxheSBkZXZpY2UgT0YNCj4gPiA+ID4gZ3JhcGguDQo+ID4gPiA+IFRoZXNlIGRpc3Bs
YXkgZGV2aWNlIHdvdWxkIG91dHB1dCB2aWRlbyBkYXRhIGZyb20gb25lIGRldmljZQ0KPiA+ID4g
PiBhbmQNCj4gPiA+ID4gaW5wdXQNCj4gPiA+ID4gdG8gYW5vdGhlciB2aWRlbyBkZXZpY2UuIFRo
ZXNlIHZpZGVvIGRldmljZSB3b3VsZCBub3QgaW5wdXQgb3INCj4gPiA+ID4gb3V0cHV0DQo+ID4g
PiA+IHZpZGVvIGRhdGEgdG8gbW1zeXMvdmRvc3lzLg0KPiA+ID4gPiANCj4gPiA+ID4gPiANCj4g
PiA+ID4gPiBUaGlzIG1lYW5zIHRoYXQgdGhlIFZET1NZUyBpcyByZWFsbHkgdGhlICJtYXN0ZXIi
IG9mIHRoZQ0KPiA+ID4gPiA+IGRpc3BsYXkNCj4gPiA+ID4gPiBwaXBlbGluZSBzaW5jZQ0KPiA+
ID4gPiA+IGV2ZXJ5dGhpbmcgZ2V0cyBlbmFibGVkLCBtaXhlZCBhbmQgbWF0Y2hlZCBmcm9tIHRo
ZXJlIC0gYW5kDQo+ID4gPiA+ID4gdGhhdCdzIGluDQo+ID4gPiA+ID4gdGhlIHNlbnNlDQo+ID4g
PiA+ID4gb2YgaGFyZHdhcmUgb3BlcmF0aW9uLCBzbyB3ZSBhcmUgKnJlYWxseSogKGFuZCBub3QN
Cj4gPiA+ID4gPiB2aXJ0dWFsbHkhKQ0KPiA+ID4gPiA+IGZsaXBwaW5nIHN3aXRjaGVzLg0KPiA+
ID4gPiANCj4gPiA+ID4gSSBhZ3JlZSBtbXN5cy92ZG9zeXMgaXMgbWFzdGVyIG9mIHZpZGVvIHBp
cGVsaW5lLCBzbyBsZXQncw0KPiA+ID4gPiBkZWZpbmUNCj4gPiA+ID4gd2hhdA0KPiA+ID4gPiB0
aGUgcG9ydCBpbiBtbXN5cy92ZG9zeXMgaXMuIElmIHRoZSBwb3J0IG1lYW5zIHRoZSBtYXN0ZXIN
Cj4gPiA+ID4gcmVsYXRpb25zaGlwLA0KPiA+ID4gPiBtbXN5cy92ZG9zeXMgc2hvdWxkIG91dHB1
dCBwb3J0IHRvIGV2ZXJ5IGRpc3BsYXkgZGV2aWNlLiBPciB1c2UNCj4gPiA+ID4gYQ0KPiA+ID4g
PiBzaW1wbHkgd2F5IHRvIHNob3cgdGhlIG1hc3RlciByZWxhdGlvbiBzaGlwDQo+ID4gPiA+IA0K
PiA+ID4gPiBtbXN5cy1zdWJkZXYgPSA8Jm92bDAsICZyZG1hMCwgJmNvbG9yMCwgLi4uPiwgPCZv
dmwxLCAmcmRtYTEsDQo+ID4gPiA+ICZjb2xvcjEsDQo+ID4gPiA+IC4uLj47DQo+ID4gPiA+IA0K
PiA+ID4gDQo+ID4gPiBUaGVyZSdzIG5vIG5lZWQgdG8gbGlzdCBhbGwgb2YgdGhlIFZETzAvVkRP
MS9tbXN5cyBkZXZpY2VzIGluIG9uZQ0KPiA+ID4gYmlnDQo+ID4gPiBhcnJheQ0KPiA+ID4gcHJv
cGVydHksIGJlY2F1c2UgdGhlIGFjdHVhbCBwb3NzaWJsZSBkZXZpY2VzIGNhbiBiZSBkZWZpbmVk
Og0KPiA+ID4gICAgIDEuIEluIHRoZSBiaW5kaW5nczsgYW5kDQo+ID4gPiAgICAgMi4gSW4gdGhl
IGFjdHVhbCBPRiBncmFwaCB0aGF0IHdlIHdyaXRlIGZvciBlYWNoIFNvQytib2FyZA0KPiA+ID4g
Y29tYmluYXRpb24uDQo+ID4gPiANCj4gPiA+IEEgZ3JhcGggY2Fubm90IGNvbnRhaW4gYSBjb25u
ZWN0aW9uIHRvIGEgZGV2aWNlIHRoYXQgY2Fubm90IGJlDQo+ID4gPiBjb25uZWN0ZWQgdG8NCj4g
PiA+IHRoZSBwcmV2aW91cywgc28sIHlvdXIgIm1tc3lzLXN1YmRldiIgbGlzdCBjYW4gYmUgcmV0
cmlldmVkIGJ5DQo+ID4gPiBsb29raW5nIGF0IHRoZQ0KPiA+ID4gZ3JhcGg6DQo+ID4gPiAgICAt
IFN0YXJ0IGZyb20gVkRPMC8xIG9yIE1NU1lTDQo+ID4gPiAgICAtIFdhbGsgdGhyb3VnaCAodmlz
dWFsbHksIGV2ZW4pIE9VVFBVVCBwb3J0cw0KPiA+ID4gICAgICAtIFZETzAgKHJlYWQgb3V0cHV0
IGVwKSAtPiBvdmwwIChyZWFkIG91dHB1dCBlcCkgLT4gcmRtYTANCj4gPiA+IChyZWFkDQo+ID4g
PiBvdXRwdXQgZXApIC0+DQo+ID4gPiAgICAgICAgY29sb3IwICguLi4pIC0+IGV0Yw0KPiA+ID4g
ICAgLSBOb3RoaW5nIG1vcmUgLSBpdCdzIGFsbCBkZWZpbmVkIHRoZXJlLg0KPiA+ID4gDQo+ID4g
PiA+IA0KPiA+ID4gPiBBbm90aGVyIHByb2JsZW0gaXMgaG93IHRvIGdyb3VwIGRpc3BsYXkgZGV2
aWNlPyBJZiB0d28gcGlwZWxpbmUNCj4gPiA+ID4gY291bGQNCj4gPiA+ID4gYmUgcm91dGUgdG8g
dGhlIHNhbWUgZGlzcGxheSBpbnRlcmZhY2UsIHN1Y2ggYXMNCj4gPiA+ID4gDQo+ID4gPiA+IHJk
bWEwIC0+IGRzaQ0KPiA+ID4gPiByZG1hMSAtPiBkc2kNCj4gPiA+ID4gDQo+ID4gPiA+IFdvdWxk
IHRoaXMgYmUgc2luZ2xlIGdyb3VwPw0KPiA+ID4gDQo+ID4gPiBUaGVyZSBhcmUgbXVsdGlwbGUg
d2F5cyBvZiBkb2luZyB0aGlzLCBidXQgb25lIHRoYXQgY29tZXMgdG8gbXkNCj4gPiA+IG1pbmQN
Cj4gPiA+IHJpZ2h0IG5vdyBhbmQNCj4gPiA+IHRoYXQgbG9va3MgY2xlYW4gYXMgd2VsbCBpcyB0
aGUgZm9sbG93aW5nOg0KPiA+ID4gDQo+ID4gPiBvdmwwQGVmMDEgew0KPiA+ID4gICAgICAuLi4u
Lg0KPiA+ID4gICAgIHBvcnRzIHsNCj4gPiA+ICAgICAgIHBvcnRAMCB7DQo+ID4gPiAgICAgICAg
IHJlZyA9IDwwPjsNCj4gPiA+ICAgICAgICAgb3ZsMF9pbjogZW5kcG9pbnQgew0KPiA+ID4gICAg
ICAgICAgIHJlbW90ZS1lbmRwb2ludCA9IDwmdmRvc3lzMF9vdXQ+Ow0KPiA+ID4gICAgICAgICB9
Ow0KPiA+ID4gICAgICAgfTsNCj4gPiANCj4gPiBJJ20gbm90IHN1cmUgaG93IGRvIHlvdSBkZWZp
bmUgdGhpcyBwb3J0IGZyb20gT1ZMIHRvIHZkb3N5cy4gSWYNCj4gPiB0aGlzDQo+ID4gcG9ydCBt
ZWFucyAnbWFzdGVyIHJlbGF0aW9uc2hpcCcsIG90aGVycyBjb3VsZCBhZGQgcG9ydCBpbiBDT0xP
UiB0bw0KPiA+IHBvaW50IHRvIHZkb3N5cyBiZWNhdXNlIENPTE9SIGFuZCB2ZG9zeXMgaGFzIHRo
ZSAnbWFzdGVyDQo+ID4gcmVsYXRpb25zaGlwJw0KPiA+IGFuZCBJIGNvdWxkIG5vdCByZWplY3Qg
dGhpcy4gU28gd2UgbmVlZCBtb3JlIHNwZWNpZmljIGRlZmluaXRpb24gb2YNCj4gPiB0aGlzIHBv
cnQuDQo+IA0KPiANCj4gPiBPbmx5IHRoZSAnZmlyc3QnIGRldmljZSBpbiBwaXBlbGluZSBjb3Vs
ZCBoYXZlIHRoaXMgcG9ydD8NCj4gDQo+IENvcnJlY3QuIE9ubHkgdGhlIGZpcnN0IGRldmljZSBp
biBhIHBpcGVsaW5lIC0gYW5kIHRoaXMgaXMgYWN0dWFsbHkgYQ0KPiByZXN0cmljdGlvbg0KPiB0
aGF0IHRoZSBnZW5lcmljIGJpbmRpbmcgZGVmaW5pdGlvbiBvZiBwb3J0IGFscmVhZHkgZ2l2ZXMs
IGluIGEgd2F5Lg0KPiANCj4gDQo+ID4gSW4gbXQ4MTczLCBvbmUgcGlwZWxpbmUgaXMNCj4gPiAN
Cj4gPiBvdmwgLT4gY29sb3IgLT4gYWFsIC0+IG9kIC0+IHJkbWEgLT4gdWZvIC0+IGRzaQ0KPiA+
IA0KPiA+IEJ1dCByZG1hIGhhcyBhbiBvcHRpb24gdG8gcmVhZCBkYXRhIGZyb20gb2Qgb3IgZGly
ZWN0bHkgZnJvbSBEUkFNLg0KPiA+IElmDQo+ID4gZnJvbSBEUkFNLCB0aGUgcGlwZWxpbmUgd291
bGQgYmUgY2hhbmdlZCB0bw0KPiA+IA0KPiA+IHJkbWEgLT4gdWZvIC0+IGRzaQ0KPiA+IA0KPiA+
IA0KPiA+IFNvIGl0J3MgY29uZnVzZWQgd2hpY2ggb25lIGlzICdmaXJzdCcuDQo+IA0KPiBUaGF0
J3Mgd2h5IHRoZSBwaXBlbGluZSBpcyAqYm9hcmQtc3BlY2lmaWMqIGFuZCBub3Qgc29jLWdlbmVy
aWMhDQo+IA0KPiBBbmQgd2hhdCB5b3UgZGVzY3JpYmVkIGlzICpleGFjdGx5KiB0aGUgcmVhc29u
IHdoeSBJJ20gYWRkaW5nIHN1cHBvcnQNCj4gZm9yIHRoZQ0KPiBPRiBncmFwaHMgaW4gbWVkaWF0
ZWstZHJtOiBzcGVjaWZ5aW5nIHRoZSBjb3JyZWN0IHBpcGVsaW5lIGZvciBlYWNoDQo+IGJvYXJk
IGFzIHBlcg0KPiB3aGF0IGVhY2ggYm9hcmQgd2FudHMgdG8gdXNlIChzYWlkIGRpZmZlcmVudGx5
OiBmb3IgZWFjaCBib2FyZCdzDQo+ICpjYXBhYmlsaXRpZXMqKS4NCj4gDQo+IFNvLCBpZiBvbiBh
IGNlcnRhaW4gYm9hcmQgeW91IHdhbnQgdG8gc2tpcCBPRCwgeW91IGNhbiBob29rIFJETUEgdXAN
Cj4gZGlyZWN0bHkgdG8NCj4gTU1TWVMvVkRPU1lTLg0KPiANCj4gSW4gTVQ4MTczLCBvbmUgcGlw
ZWxpbmUgZm9yIG9uZSBib2FyZCB1c2VzIGVuZHBvaW50cyBJTi9PVVQgbGlrZQ0KPiB0aGlzOg0K
PiANCj4gTU1TWVMgLT4gT1ZMIC0+IENPTE9SIC0+IEFBTCAtPiBPRCAtPiBSRE1BIC0+IFVGTyAt
PiBEU0kNCj4gDQo+IGFuZCBmb3IgYW5vdGhlciBib2FyZCwgZW5kcG9pbnRzIHdpbGwgYmUgbGlr
ZQ0KPiANCj4gTU1TWVMgLT4gUkRNQSAtPiBVRk8gLT4gRFNJDQo+IA0KPiAuLi53aGljaCBpcyB0
aGUgZXhhY3Qgc2FtZSBhcyB5b3UgZGVzY3JpYmVkLCBhbmQgSSB0aGluayB0aGF0IHlvdXINCj4g
Y29uZnVzaW9uIGNvbWVzDQo+IGZyb20gdGhlIGZhY3QgdGhhdCB5b3UgZGlkbid0IHB1dCBNTVNZ
UyBhdCB0aGUgYmVnaW5uaW5nIG9mIHRoZQ0KPiBwaXBlbGluZSA6LSkNCg0KSW4gb25lIGJvYXJk
LCBib3RoIE9WTCBhbmQgUkRNQSBjb3VsZCBzd2l0Y2ggZHluYW1pY2FsbHkuIEJlY2F1c2UgZWFj
aA0Kb25lIGNvdWxkIGJlIHRoZSBmaXJzdCBpbiBvbmUgYm9hcmQsIG1tc3lzIHBvaW50IHRvIGJv
dGggb3ZsIGFuZCByZG1hPw0KDQpSZWdhcmRzLA0KQ0sNCg0KPiANCj4gDQo+IA0KPiANCj4gSW4g
Y2FzZSB5b3UgbmVlZCBhbnkgKnRlbXBvcmFyeSBvdmVycmlkZSogb24gYW55IGJvYXJkIHRoYXQg
ZGVmaW5lcyBhDQo+IHBpcGVsaW5lIGxpa2UNCj4gDQo+IE1NU1lTIC0+IE9WTCAtPiBDT0xPUiAt
PiBBQUwgLT4gT0QgLT4gUkRNQSAtPiBVRk8gLT4gRFNJDQo+IA0KPiBzbyB0aGF0IHRoZSBwaXBl
bGluZSAqdGVtcG9yYXJpbHkqIGJlY29tZXMgKGZvciBwb3dlciBtYW5hZ2VtZW50LCBvcg0KPiBm
b3IgYW55IG90aGVyDQo+IHJlYXNvbikgUkRNQSAtPiBVRk8gLT4gRFNJIC4uLi4gdGhhdCdzIG5v
dCBhIGNvbmNlcm46IHRoZSBncmFwaCBpcw0KPiBwcmVzZW50LCBhbmQgaXQNCj4gaXMgdXNlZCB0
byB0ZWxsIHRvIHRoZSBkcml2ZXIgd2hhdCBpcyB0aGUgcmVndWxhciBwaXBlbGluZSB0byB1c2Uu
DQo+IEV2ZW50dWFsIHRlbXBvcmFyeSBvdmVycmlkZXMgY2FuIGJlIG1hbmFnZWQgdHJhbnNwYXJl
bnRseSBpbnNpZGUgb2YNCj4gdGhlIGRyaXZlciB3aXRoDQo+IEMgY29kZSBhbmQgbm8gY2hhbmdl
cyB0byB0aGUgZGV2aWNldHJlZSBhcmUgcmVxdWlyZWQuDQo+IA0KPiANCj4gPiBJIGRvbid0IGtu
b3cgaG93IHRvIGRlY2lkZSB3aGljaCBkZXZpY2UgY291bGQgcG9pbnQgdG8NCj4gPiBtbXN5cy92
ZG9zeXMuIFNvDQo+ID4gcGxlYXNlIGdpdmUgYSBzcGVjaWZpYyBkZWZpbml0aW9uLg0KPiA+IA0K
PiANCj4gTm90aGluZyBwb2ludHMgVE8gbW1zeXMvdmRvc3lzLiBJdCBpcyBtbXN5cy92ZG9zeXMg
cG9pbnRpbmcgdG8gYQ0KPiBkZXZpY2UuDQo+IA0KPiBTbywgbW1zeXMvdmRvc3lzIG11c3QgcG9p
bnQgdG8gdGhlICpmaXJzdCBkZXZpY2UgaW4gdGhlIHBpcGVsaW5lKi4NCj4gDQo+IEFueSBvdGhl
ciBkb3VidD8NCj4gDQo+IENoZWVycywNCj4gQW5nZWxvDQo+IA0KPiA+IFJlZ2FyZHMsDQo+ID4g
Q0sNCj4gPiANCj4gPiA+IA0KPiA+ID4gICAgICAgcG9ydEAxIHsNCj4gPiA+ICAgICAgICAgcmVn
ID0gPDE+Ow0KPiA+ID4gICAgICAgICBvdmwwX291dDA6IGVuZHBvaW50QDAgew0KPiA+ID4gICAg
ICAgICAgIHJlbW90ZS1lbmRwb2ludCA9IDwmcmRtYTBfaW4+Ow0KPiA+ID4gICAgICAgICB9Ow0K
PiA+ID4gICAgICAgICBvdmwwX291dDE6IGVuZHBvaW50QDEgew0KPiA+ID4gICAgICAgICAgIHJl
bW90ZS1lbmRwb2ludCA9IDwmcmRtYTFfaW4+Ow0KPiA+ID4gICAgICAgICB9Ow0KPiA+ID4gICAg
ICAgfTsNCj4gPiA+ICAgICB9Ow0KPiA+ID4gfTsNCj4gPiA+IA0KPiA+ID4gcmRtYTBAMTIzNCB7
DQo+ID4gPiAgICAgIC4uLi4uDQo+ID4gPiAgICAgcG9ydHMgew0KPiA+ID4gICAgICAgcG9ydEAw
IHsNCj4gPiA+ICAgICAgICAgcmVnID0gPDA+Ow0KPiA+ID4gICAgICAgICByZG1hMF9pbjogZW5k
cG9pbnQgew0KPiA+ID4gICAgICAgICAgIHJlbW90ZS1lbmRwb2ludCA9IDwmb3ZsMF9vdXQwPjsg
LyogYXNzdW1pbmcgb3ZsMA0KPiA+ID4gb3V0cHV0cyB0bw0KPiA+ID4gcmRtYTAuLi4qLw0KPiA+
ID4gICAgICAgICB9Ow0KPiA+ID4gICAgICAgfTsNCj4gPiA+ICAgICAgIHBvcnRAMSB7DQo+ID4g
PiAgICAgICAgIHJlZyA9IDwxPjsNCj4gPiA+ICAgICAgICAgcmRtYTBfb3V0OiBlbmRwb2ludEAx
IHsNCj4gPiA+ICAgICAgICAgICByZW1vdGUtZW5kcG9pbnQgPSA8JmRzaV9kdWFsX2ludGYwX2lu
PjsNCj4gPiA+ICAgICAgICAgfTsNCj4gPiA+ICAgICAgIH07DQo+ID4gPiAgICAgfTsNCj4gPiA+
IH07DQo+ID4gPiANCj4gPiA+IA0KPiA+ID4gcmRtYTFANTY3OCB7DQo+ID4gPiAgICAgIC4uLi4u
DQo+ID4gPiAgICAgcG9ydHMgew0KPiA+ID4gICAgICAgcG9ydEAwIHsNCj4gPiA+ICAgICAgICAg
cmVnID0gPDA+Ow0KPiA+ID4gICAgICAgICByZG1hMV9pbjogZW5kcG9pbnQgew0KPiA+ID4gICAg
ICAgICAgIC8qIGFzc3VtaW5nIG92bDAgb3V0cHV0cyB0byByZG1hMSBhcyB3ZWxsLi4uIGNhbiBi
ZQ0KPiA+ID4gc29tZXRoaW5nIGVsc2UuICovDQo+ID4gPiAgICAgICAgICAgcmVtb3RlLWVuZHBv
aW50ID0gPCZvdmwwX291dDE+Ow0KPiA+ID4gICAgICAgICB9Ow0KPiA+ID4gICAgICAgfTsNCj4g
PiA+ICAgICAgIHBvcnRAMSB7DQo+ID4gPiAgICAgICAgIHJlZyA9IDwxPjsNCj4gPiA+ICAgICAg
ICAgcmRtYTFfb3V0OiBlbmRwb2ludCB7DQo+ID4gPiAgICAgICAgICAgcmVtb3RlLWVuZHBvaW50
ID0gPCZkc2lfZHVhbF9pbnRmMV9pbj47DQo+ID4gPiAgICAgICAgIH07DQo+ID4gPiAgICAgICB9
Ow0KPiA+ID4gICAgIH07DQo+ID4gPiB9Ow0KPiA+ID4gDQo+ID4gPiANCj4gPiA+IGRzaUA5YWJj
ZCB7DQo+ID4gPiAgICAgIC4uLi4uDQo+ID4gPiAgICAgcG9ydHMgew0KPiA+ID4gICAgICAgcG9y
dEAwIHsNCj4gPiA+ICAgICAgICAgcmVnID0gPDA+Ow0KPiA+ID4gICAgICAgICAvKiBXaGVyZSBl
bmRwb2ludEAwIGNvdWxkIGJlIGFsd2F5cyBEU0kgTEVGVCBDVFJMICovDQo+ID4gPiAgICAgICAg
IGRzaV9kdWFsX2ludGYwX2luOiBlbmRwb2ludEAwIHsNCj4gPiA+ICAgICAgICAgICByZW1vdGUt
ZW5kcG9pbnQgPSA8JnJkbWEwX291dD47DQo+ID4gPiAgICAgICAgIH07DQo+ID4gPiAgICAgICAg
IC8qIC4uLmFuZCBAMSBjb3VsZCBiZSBhbHdheXMgRFNJIFJJR0hUIENUUkwgKi8NCj4gPiA+ICAg
ICAgICAgZHNpX2R1YWxfaW50ZjFfaW46IGVuZHBvaW50QDEgew0KPiA+ID4gICAgICAgICAgIHJl
bW90ZS1lbmRwb2ludCA9IDwmcmRtYTFfb3V0PjsNCj4gPiA+ICAgICAgICAgfTsNCj4gPiA+ICAg
ICAgIH07DQo+ID4gPiANCj4gPiA+ICAgICAgIHBvcnRAMSB7DQo+ID4gPiAgICAgICAgIHJlZyA9
IDwxPjsNCj4gPiA+ICAgICAgICAgZHNpMF9vdXQ6IGVuZHBvaW50IHsNCj4gPiA+ICAgICAgICAg
ICByZW1vdGUtZW5kcG9pbnQgPSA8JmRzaV9wYW5lbF9pbj47DQo+ID4gPiAgICAgICAgIH07DQo+
ID4gPiAgICAgICB9Ow0KPiA+ID4gICAgIH07DQo+ID4gPiB9Ow0KPiA+ID4gDQo+ID4gPiAuLi5m
b3IgYSBkdWFsLWRzaSBwYW5lbCwgaXQnZCBiZSBhIHNpbWlsYXIgZ3JhcGguDQo+ID4gPiANCj4g
PiA+IENoZWVycywNCj4gPiA+IEFuZ2Vsbw0KPiA+ID4gDQo+ID4gPiA+IA0KPiA+ID4gPiBtbXN5
cy1zdWJkZXYgPSA8JnJkbWEwLCAmcmRtYTEsICZkc2k+Ow0KPiA+ID4gPiANCj4gPiA+ID4gT3Ig
dHdvIGdyb3VwPw0KPiA+ID4gPiANCj4gPiA+ID4gbW1zeXMtc3ViZGV2ID0gPCZyZG1hMCwgJmRz
aT4sIDwmcmRtYTEsICZkc2k+Ow0KPiA+ID4gPiANCj4gPiA+ID4gSSB0aGluayB3ZSBzaG91bGQg
Y2xlYXJseSBkZWZpbmUgdGhpcy4NCj4gPiA+ID4gDQo+ID4gPiA+IFJlZ2FyZHMsDQo+ID4gPiA+
IENLDQo+ID4gPiA+IA0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IENoZWVycywN
Cj4gPiA+ID4gPiBBbmdlbG8NCj4gPiA+ID4gPiANCj4gPiA+ID4gPiA+IFJlZ2FyZHMsDQo+ID4g
PiA+ID4gPiBDSw0KPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+ID4gICAg
IHJlcXVpcmVkOg0KPiA+ID4gPiA+ID4gPiAgICAgICAtIGNvbXBhdGlibGUNCj4gPiA+ID4gPiA+
ID4gICAgICAgLSByZWcNCj4gPiA+ID4gPiANCj4gPiA+ID4gPiANCj4gPiA+IA0KPiA+ID4gDQo+
ID4gPiANCj4gDQo+IA0K

