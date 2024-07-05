Return-Path: <linux-kernel+bounces-242236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0441292853E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 11:37:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 791771F24D64
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 09:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BCD2147C9B;
	Fri,  5 Jul 2024 09:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="hvuHufjq";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="UYdyLWV1"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F8341482E1
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 09:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720172201; cv=fail; b=jr0svrfnmumrwrRhPHi7GeMPrkJetyb+kry9Rk4HJiH9fmbzl5Pkv7h1DTBJa8Tqpd2lNEjWQ8uitmPZuMCZFeqQwXtmnhIZLglqigLebnPEcUNOdt434rEo3ohOxrqgITJ51cGkcb0YsnrjpXaOp5+PT+8UNzQxhAqVx2XSGQM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720172201; c=relaxed/simple;
	bh=3qVc+WNvvDlhJPyp6D3AEDvBCZH3NJV1nDBgH/6fp38=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qdsktOrsYH2hNGqxv26mvyOqWvVNxzN1V6nOP/q8b6i7pJv6ZNNLo1VA0K0J2DTVK+kRRNJRGd8AgswYIZfVuHMJMtAB2DbfcKY3DhXO6plgbtAlAuXWYoS0EPhBgNnWlciG7znSHSGId+cDdiNb/sr7IOzpxVKywwesaBmkm5w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=hvuHufjq; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=UYdyLWV1; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 11d1fa803ab211ef99dc3f8fac2c3230-20240705
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=3qVc+WNvvDlhJPyp6D3AEDvBCZH3NJV1nDBgH/6fp38=;
	b=hvuHufjqkJBiIPFB/7CKkQ0y66Sh4aMo3MzyqmRACPIaFXxf2aKdMSb0g0Gd7mKq+eJ1PS67ruy/5HJc9aQiFVSd4iLcIQ39WCgBsM4SJp1B+oClonIvgJ7TaW+R5l+GOJs1C9OQKxNDKsPzKHxBuwlXU4QrBRRKXPoh07Fh0Pg=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.40,REQID:8c5943c9-f9a5-4ac0-ae44-4a918e38838b,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:ba885a6,CLOUDID:1656fed4-0d68-4615-a20f-01d7bd41f0bb,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 11d1fa803ab211ef99dc3f8fac2c3230-20240705
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1174796753; Fri, 05 Jul 2024 17:36:34 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 5 Jul 2024 02:36:33 -0700
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 5 Jul 2024 17:36:33 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TbrT4/KvTM+78GW771WMfMgj5yisD9Vphb7tZ/ATr7abj9DaOHYyqjK7tlv7qQasnExZYe0GA5pSfMdUh+1tcjHDe8cGE8mfpYPD95cV7i5dUmY1Vq3sIvbiNQJ64u/AEduGgr7h4Hziy4hWhawy7sk+ItnngaH3NOd1e1bhdYBfm5WaFJlYiKe8J1vo3QuVXUNp90DuboUiOk5Bn/gGyfNf2NWahKI0UDI4WvCSYKql2l54UxWPJF/85bIbDLWwT8IGbzFK9FQweDGLRDwh6DtWsLq9jW851Qbs4ly1Lw7CreBMkRTbe5gGqTzQBhnzL/FzxDWWZ7AvUt73oPIaVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3qVc+WNvvDlhJPyp6D3AEDvBCZH3NJV1nDBgH/6fp38=;
 b=QFLJTGsSvtmXW2CvoQiaIvbR0mMDe9b05D/0B60uUOlxoDtBOlTXATJgJHTWR43sjncUs3MBSVBinaEiCXhfcJXKg5lIM9YRCb658q/Y/clkdwyxJ3P4t8/EpeUqtr0zY1agbbQU5O8OpoZf3E0m6xvEqznywcI4LXEz0/QGK4OoBThMZSja1syq7yHtefdpby+p5dVWxQaf44nvaZGjS9jNtpDbZKYkvAz0nhkAG8CK6eZyfuxFJFNXhXT7eT7oYEm9YNs2luQaQ2KBiRgeMxIzzpcs3mVl6ifZUtsvKcYqHvl0PoMGJKp/HLkFn1Wtl++HBAX4UOuLimpby1MXyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3qVc+WNvvDlhJPyp6D3AEDvBCZH3NJV1nDBgH/6fp38=;
 b=UYdyLWV12rPFI24YCa/UwlaJ5s/Mx/UY8sUxNqyeJmSCCyU+uz0Y7odKJiqRRtFs9CM2OqDNiBjAO8nPjGei+8H91FeGZLRYpJ09jKgCq21SLKtivmP0ZB4/JHtP2lMdK4W4a/lrUUmBhJZBC5P0rmq+o/ZMAaG5PoeqSws9oJ8=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by KL1PR03MB7902.apcprd03.prod.outlook.com (2603:1096:820:fa::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.30; Fri, 5 Jul
 2024 09:36:31 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54%6]) with mapi id 15.20.7719.029; Fri, 5 Jul 2024
 09:36:31 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
	=?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= <Shawn.Sung@mediatek.com>,
	"airlied@gmail.com" <airlied@gmail.com>, "daniel@ffwll.ch" <daniel@ffwll.ch>,
	"chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
	"angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 2/5] drm/mediatek: Support "None" blending in Mixer
Thread-Topic: [PATCH 2/5] drm/mediatek: Support "None" blending in Mixer
Thread-Index: AQHawm4CehGZ7j4H80uVSodFizERF7HhNh2AgASsKoCAAhZ/gA==
Date: Fri, 5 Jul 2024 09:36:31 +0000
Message-ID: <485bdfc093eb34527e74051c643eb7f1ecccb999.camel@mediatek.com>
References: <20240620-blend-v1-0-72670072ca20@mediatek.com>
	 <20240620-blend-v1-2-72670072ca20@mediatek.com>
	 <5374029c58dbb4e2c23f86e74eabbde7b2ae7b78.camel@mediatek.com>
	 <278a57fc81fb803ffc65d4805c321cce4b6952d2.camel@mediatek.com>
In-Reply-To: <278a57fc81fb803ffc65d4805c321cce4b6952d2.camel@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|KL1PR03MB7902:EE_
x-ms-office365-filtering-correlation-id: c6ed8d5b-7da2-4232-286e-08dc9cd5f413
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?dVp5NkJKMk5nRXhqS2tMMkJZZytCQTlxQjBYY2hFTEFNNTVEMlpMMnlpWjRr?=
 =?utf-8?B?UzRhazhpcGxQOTBMZ0RGNFpGZTJxclRML1RVdk5UNG8zUnJ0dUxDNFZMVmtD?=
 =?utf-8?B?T29wUGhpTjZYSGFTVXNEMzVNUU4vNHNoeWtyVHZQajdReEMrc1lxc0tQRDk1?=
 =?utf-8?B?Y3kzcGowZjN6aHdyS2l5bW54UHJMQjlpbGxMcjVlUlYrY2lGR0JuQUZIT3lT?=
 =?utf-8?B?YUFOVk5kVzdWdkZRTGJvN2FIbnF6ZnpubncrWEo1Qk0wT3UrenVsdDhCMjRk?=
 =?utf-8?B?NmlWVjNaeng2RzNBaEo1T21pZHl0ek4vOGN4MkJRdlQ0ZXNMSWRZYWNsMnhB?=
 =?utf-8?B?OVlsTXRGZzlYZlMyZXQ2SU1EYjRmMmNRWVcwaGpKWUovdDU4ajB4YVFrVFh3?=
 =?utf-8?B?UHJXT1lncjM0WlArVnNEVUJUOG56SlU2MG5mOVk3eFZPWUxLdEJRVVN3bjRR?=
 =?utf-8?B?M3BJWncxV2VxWS9mZkxKVHFpT0cwZDdBL0F5SllJSmtiYnBUeDI1Z2xzS1Js?=
 =?utf-8?B?ODRuMHNRQ0NGdHJSblRWYnlkYUtXdzJURktrYUhpRXI1MXVweDl5ckhJR2ZY?=
 =?utf-8?B?NWNMdUNiVXQ0d09OK3hhTWRQZHhnRmZuWEdMTVJmR2JKYjJFZnRWeHdZT1pz?=
 =?utf-8?B?dVplZllUcHpQQlBZL25xMEFEendwbGk1c3JiVk8rcmhkMjJUVmFpbFEyMzl4?=
 =?utf-8?B?ZER5dEtjbDVzUEhwZmxCcWFFTFY2UXpSUHFPbXZ3Y2lMdSszMnlLRDhLeVN1?=
 =?utf-8?B?RHNIakVRbHRUZ1YrMTlYd280SXBWd0toZXVvOXlRUzNSQ3FreVcxN2FrUXlT?=
 =?utf-8?B?MGsvcHRYVHNFWklkcUJnbWZicUppcmRjYXhabnBwWkdNUjhjay9pOGNvQmx3?=
 =?utf-8?B?ZXVmTXlHd080RW9iU3FETWtvRWhyVU9leVdxbUIzcTNOR3d2QmNURE0rbkUv?=
 =?utf-8?B?VDBQVDlIZlhDWjgwbGtlTFdiY1hkVXlsNlE1eFVRekNPM05lOUwwVHlWYmJm?=
 =?utf-8?B?L0NTTHdGaVFnWFVNSjEreStKb2FaeWdxYkZsTTNGaDhtaHh1a0ZDaVpqOVhw?=
 =?utf-8?B?bFYvMlpZeUhDbTZOTTFQSXFxSlNhS3FxQkYwQU5zaHJvb2dxTUthRGdjbm05?=
 =?utf-8?B?Y1hIb1QyMGtKaGJPOS82Nm9abmQxNUtlUS9wNHJueXJGTnR3emxlRVJ3OE5i?=
 =?utf-8?B?MEkyMlJ4RmttVUlQbDh6NzFNSjdQb1BTcndkMldxc2Iwelk4bFB2TU44VDlF?=
 =?utf-8?B?RDludVBsSm55M1VnNmt3M1FONTBKc0VjcngwWmVFR2NNYkhvYzVzRkFLbnFp?=
 =?utf-8?B?UTlGRC93MG5Qam5Oa3JLQUljT2J5VHd6YmIwaW11bUUwUXRqaDZ6cnZHaXRl?=
 =?utf-8?B?SUhvdjZqT1FFcFNJWUJZRDJtV3RLNUpsb09ScGh0NG5zdWVQaVpJUzBqZE8r?=
 =?utf-8?B?SElUcFgrK3UrV2MxbmlGZjJxYmhBbzVZVXpraDdKQkVkMWR0ZlRGMXRsZEM1?=
 =?utf-8?B?eU4zOVNjWTFQeUtuTHpFWEZJdldTSEJ2bEl3RkppZzJYWkFhb0RYN2wrOVlv?=
 =?utf-8?B?RzBrZHU0TXp0TERHZW5xZjhIelA3RWU5Qk1yMjAwd0hGWVlPeEZ5YmZkV0Fv?=
 =?utf-8?B?MUVlQWc1SWRNQlovL0NXSXNpQWhnUzNCaWdJeUFhWmNLeEZNaHcvbUMvZndL?=
 =?utf-8?B?azdvaW1zcUVTV0l6OTBFUExVZVd0dExpRkJoM0ZpVWVDMXc1b3dYZlBsd0Fw?=
 =?utf-8?B?bkVTVks0N1FLbzB1RFlZcThBRW9xandhVnMwazJ4TFFOSEI0amlHNDdyMjkr?=
 =?utf-8?B?bC9kSzE1WmxJR2tjUU81cUNGTCtNMldTUlVHbFM2b0VVaUZONkRzVUN5N08y?=
 =?utf-8?B?OVRkMmxKblFoZ01YSG9YYWIwNWFRekp5bmZBVWsxdGVzMGc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ejFSZThSdVY1RVFWK0cxZ1I1N2lHdkNoN1ROSTZsYzBraXNKQkwxZmhMeUJW?=
 =?utf-8?B?RVl3R3ZkbmdsUXgwYlBtTkQ4SzBWZ2I5VzdHTkI0V0REa3p0VCtaZDlFUWNy?=
 =?utf-8?B?Rm5ObTJVbG9OZEVlWCtKb2w3SWd3OVNGdm84MUx2OVQ5QkVaZ3N1Z0F1U2lp?=
 =?utf-8?B?Z2F6S3U0Kzc2OFpFUkNpOTJtRCtQQWRCRmNZMXNpdExrZklOUk9wVStqd29i?=
 =?utf-8?B?Ky9iQmcwb2M2dmVQdU0vRTMwMk4wN2hZZENUanZHZURZU3lNNmdreUVvWG13?=
 =?utf-8?B?UUlNVUlBMXFhUDRmcm1uSUYvQWZGTGNETlhjRmpoZlNZd2lIYWw4L2RWSlFN?=
 =?utf-8?B?MnpHcW9mbjkrV3grUUUwN1kvd3JaMHN3WE5kaXd4cGRTMHZsNmYrSXNNTHpE?=
 =?utf-8?B?bldwT0NUdlBXTTQwRmJQMnh4MnNpR3JWbVl0WGlFMC9EakJBWm12SGE0a0NB?=
 =?utf-8?B?cFFybzEwbzVmbkxYTUlZM3VCQnJVSElUNWp4ZlFDTkZzQmF4d1BxUzY1RTFm?=
 =?utf-8?B?a1dYWi9GUjZXcGRBcEdBS2hoZ3FKTGUzeWhGTUlQRlZ1MjQrcUJ4QVdlaG5J?=
 =?utf-8?B?SmpKS1hWR0trMUFsS3FKRmFjTWlVY3MzblU1T2ZITkljZUE3ZUtXWHEzUjgz?=
 =?utf-8?B?SDYwdTl6V1g1aTlpZUVtSTdOblR1UmF3RytUK1pISlQ1V0MwR0RId0pWbDB0?=
 =?utf-8?B?N1dvc3RLRnFUbEIvT3BFZzlvQTR0SkZpbVFzTG1BUVZrbFlxeElWbTdvUENH?=
 =?utf-8?B?anU2czgyQ2FLTXRhUXpUUTBQRVNHYlZ4ektuVm90M2s5V3A5dzhFNkFzK0wx?=
 =?utf-8?B?N3RkOWNTbFdHM2RkK3VOUlpvN1hVK25ZZi9jazRBaGNnYVFzYlhDZ3cwZ09Q?=
 =?utf-8?B?dnoxczRHYS9ZMVBZcm1LS1NNdWtBWW9pbldHRHIrc0cyMk85T05vSXp2aVhU?=
 =?utf-8?B?ekpraUxWdkl6eHBKWmJ3eEtkVEJ4dTRJd24vYW9CV21FYU9VOWVBdHFkeXhK?=
 =?utf-8?B?Mlo3U0hYZFl3U1NHZ1BhUys5ZHRFQ3VLV0JFeWliL0VDRWdEbFAxa3NLSUht?=
 =?utf-8?B?dStzdXNJdkVxcEg0TWRFTHE4d1Q5VXowTjY2L3krTGRWVmovMTRHbHNFVmFI?=
 =?utf-8?B?a1p2TFhjWDNZdHN1RFRYT3FCckRlWkZrbFFrSXFFc1pwVG1ETDZNVmhCUmtx?=
 =?utf-8?B?S0FJYWZVTTZueDRmbGVQajJlVG90WXZlbDZFWjdMaWViRU15VGZjOWc5ZXRM?=
 =?utf-8?B?S3VTa0hZdmhOSDU2K0dnR0N0S3pCbXZ0a09ha0VlOFBBdkF3amk3NThkRzMz?=
 =?utf-8?B?VjhlOUR4NFVxVFMzektRK3RjOTQwcW5oemFZQzViOEcvZkZ6eGdVaXVkNFpZ?=
 =?utf-8?B?S3Z5cjdHa3dZaHd4RGNKN3BMQytmaC84S1k0VGw2OGVXM2IwQlBjbG5QdHd0?=
 =?utf-8?B?K2RCbWxVRDgzZ2lOU1RZaE5ERnR2c0xhQnNsSHZ5TGFaQTVqZy91cVVTYVQ0?=
 =?utf-8?B?Y2ZPT3U4NW16RHFrTWFyVHdQcmM1eVJCVnFkeGhrc2w1V1h5SWFIek5PckhL?=
 =?utf-8?B?K1VkV3NnYzZtdHQ2d2hNZ3h2SUMzNU1qTTNsdHF2MlV2N3U5TUZSVmJMWkdR?=
 =?utf-8?B?azVzWGpwZU9xMC9La2U1RFlXNmcvY3U0aTY1RXhzeGRCOVhBeENEZnBFQ2ZK?=
 =?utf-8?B?dm5qa3drQ0FpdUtjNjFLeDBCYnJwVmZMVXBHQm9UTjdLTU5GVGlndUkrU05O?=
 =?utf-8?B?UXZmdTJHTXJNREthS2pkUjBwYUlBU01rdFpJQTFGU1oxNzYyVVpWaUFIV29Z?=
 =?utf-8?B?YlNUcERxcUxZVE1QS1UwSUZBNmlrMnJGb3BuT0tJS0FOcnlTeFFENnI1Qm92?=
 =?utf-8?B?NzNvelBFMFo1V0NITGVQVGVnOVFzeHp3N0ZYbnpoc09DYWFtZENlc2dYc3ZJ?=
 =?utf-8?B?b1FQdGROTWJ2S3NYKzUrdkpmRWlyTGYwU2lSUXJyaEh1TXFZNGRwYVc3Mnh3?=
 =?utf-8?B?NVZhUGF2RW5nS2twY0JhakVQL0F5ZUZNR3NrZ3JKWHlmNGdORjFuUThqRCtk?=
 =?utf-8?B?cy9OMFJhc25vVTVDZkFyL2paMVFvc2NObnBEQVlNT0Uyb0lGYm1EeWRqKy9h?=
 =?utf-8?Q?XhdQqyN7FA6JudfZ1IdjRGDOE?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9DD4579E8FE4FB47B59BC9DD81A4DC5D@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6ed8d5b-7da2-4232-286e-08dc9cd5f413
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2024 09:36:31.6379
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CD3bwF2/hcfmTI3E68jKJmbWoPOtR0Ye/o/fb/runQj8gvE72DLwFPD+6DXPhtcY1aCwurBE5IB75paDhaXK4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB7902

SGksIFNoYXduOg0KDQpPbiBUaHUsIDIwMjQtMDctMDQgYXQgMDE6NDMgKzAwMDAsIFNoYXduIFN1
bmcgKOWui+WtneismSkgd3JvdGU6DQo+IEhpIENLLA0KPiANCj4gT24gTW9uLCAyMDI0LTA3LTAx
IGF0IDAyOjIyICswMDAwLCBDSyBIdSAo6IOh5L+K5YWJKSB3cm90ZToNCj4gPiBIaSwgU2hhd246
DQo+ID4gDQo+ID4gT24gVGh1LCAyMDI0LTA2LTIwIGF0IDAxOjI3ICswODAwLCBIc2lhbyBDaGll
biBTdW5nIHZpYSBCNCBSZWxheQ0KPiA+IHdyb3RlOg0KPiA+ID4gIAkgDQo+ID4gPiBFeHRlcm5h
bCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cw0K
PiA+ID4gdW50aWwgeW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRlciBvciB0aGUgY29udGVudC4N
Cj4gPiA+ICBGcm9tOiBIc2lhbyBDaGllbiBTdW5nIDxzaGF3bi5zdW5nQG1lZGlhdGVrLmNvbT4N
Cj4gPiA+IA0KPiA+ID4gU3VwcG9ydCAiTm9uZSIgYWxwaGEgYmxlbmRpbmcgbW9kZSBvbiBNZWRp
YVRlaydzIGNoaXBzLg0KPiA+ID4gDQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBIc2lhbyBDaGllbiBT
dW5nIDxzaGF3bi5zdW5nQG1lZGlhdGVrLmNvbT4NCj4gPiA+IC0tLQ0KPiA+ID4gIGRyaXZlcnMv
Z3B1L2RybS9tZWRpYXRlay9tdGtfZXRoZHIuYyB8IDEzICsrKysrKysrKystLS0NCj4gPiA+ICAx
IGZpbGUgY2hhbmdlZCwgMTAgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCj4gPiA+IA0K
PiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZXRoZHIuYw0K
PiA+ID4gYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2V0aGRyLmMNCj4gPiA+IGluZGV4
IDM2MDIxY2I4ZGY2Mi4uNDhiNzE0OTk0NDkyIDEwMDY0NA0KPiA+ID4gLS0tIGEvZHJpdmVycy9n
cHUvZHJtL21lZGlhdGVrL210a19ldGhkci5jDQo+ID4gPiArKysgYi9kcml2ZXJzL2dwdS9kcm0v
bWVkaWF0ZWsvbXRrX2V0aGRyLmMNCj4gPiA+IEBAIC0zLDYgKzMsNyBAQA0KPiA+ID4gICAqIENv
cHlyaWdodCAoYykgMjAyMSBNZWRpYVRlayBJbmMuDQo+ID4gPiAgICovDQo+ID4gPiAgDQo+ID4g
PiArI2luY2x1ZGUgPGRybS9kcm1fYmxlbmQuaD4NCj4gPiA+ICAjaW5jbHVkZSA8ZHJtL2RybV9m
b3VyY2MuaD4NCj4gPiA+ICAjaW5jbHVkZSA8ZHJtL2RybV9mcmFtZWJ1ZmZlci5oPg0KPiA+ID4g
ICNpbmNsdWRlIDxsaW51eC9jbGsuaD4NCj4gPiA+IEBAIC0zNSw2ICszNiw3IEBADQo+ID4gPiAg
I2RlZmluZSBNSVhfU1JDX0wwX0VOQklUKDApDQo+ID4gPiAgI2RlZmluZSBNSVhfTF9TUkNfQ09O
KG4pKDB4MjggKyAweDE4ICogKG4pKQ0KPiA+ID4gICNkZWZpbmUgTk9OX1BSRU1VTFRJX1NPVVJD
RSgyIDw8IDEyKQ0KPiA+ID4gKyNkZWZpbmUgUFJFTVVMVElfU09VUkNFKDMgPDwgMTIpDQo+ID4g
PiAgI2RlZmluZSBNSVhfTF9TUkNfU0laRShuKSgweDMwICsgMHgxOCAqIChuKSkNCj4gPiA+ICAj
ZGVmaW5lIE1JWF9MX1NSQ19PRkZTRVQobikoMHgzNCArIDB4MTggKiAobikpDQo+ID4gPiAgI2Rl
ZmluZSBNSVhfRlVOQ19EQ00wMHgxMjANCj4gPiA+IEBAIC0xNzUsNyArMTc3LDEzIEBAIHZvaWQg
bXRrX2V0aGRyX2xheWVyX2NvbmZpZyhzdHJ1Y3QgZGV2aWNlDQo+ID4gPiAqZGV2LCB1bnNpZ25l
ZCBpbnQgaWR4LA0KPiA+ID4gIGFscGhhX2NvbiB8PSBzdGF0ZS0+YmFzZS5hbHBoYSAmIE1JWEVS
X0FMUEhBOw0KPiA+ID4gIH0NCj4gPiA+ICANCj4gPiA+IC1pZiAoc3RhdGUtPmJhc2UuZmIgJiYg
IXN0YXRlLT5iYXNlLmZiLT5mb3JtYXQtPmhhc19hbHBoYSkgew0KPiA+ID4gK2lmIChzdGF0ZS0+
YmFzZS5waXhlbF9ibGVuZF9tb2RlID09IERSTV9NT0RFX0JMRU5EX1BJWEVMX05PTkUpDQo+ID4g
PiArYWxwaGFfY29uIHw9IFBSRU1VTFRJX1NPVVJDRTsNCj4gPiA+ICtlbHNlDQo+ID4gPiArYWxw
aGFfY29uIHw9IE5PTl9QUkVNVUxUSV9TT1VSQ0U7DQo+ID4gDQo+ID4gQ292ZXJhZ2UgbW9kZSBp
cyBhbiBhbHJlYWR5IHN1cHBvcnQgbW9kZSwgYnV0IHRoaXMgcGF0Y2ggbW9kaWZ5DQo+ID4gYWxw
aGFfY29uIGZvciBjb3ZlcmFnZSBtb2RlLg0KPiA+IFNvIHRoaXMgaXMgYSBidWcgZml4Pw0KPiAN
Cj4gSW4gb3JlZGVyIHRvIHJlcGxhY2UgdGhlIGRlZmF1bHQgc2V0dGluZyB0aGF0IGlzIHNldCBp
bg0KPiBtdGtfZXRoZHJfY29uZmlnKCksIHdlIGNoYW5nZSBtdGtfZGRwX3dyaXRlX21hc2soKSB0
byBtdGtfZGRwX3dyaXRlKCksDQo+IGFuZCB0aGlzIGNoYW5nZSB3aWxsIGFsc28gcmVzZXQgTk9O
X1BSRU1VTFRJX1NPVVJDRSBiaXQgdGhhdCB3YXMNCj4gYXNzaWduZWQgaW4gbXRrX2V0aGRyX2Nv
bmZpZygpLiBUaGVyZWZvcmUsIHdlIG11c3Qgc3RpbGwgc2V0DQo+IE5PTl9QUkVNVUxUSV9TT1VS
Q0UgYml0IGlmIHRoZSBibGVuZCBtb2RlIGlzIG5vdA0KPiBEUk1fTU9ERV9CTEVORF9QSVhFTF9O
T05FLg0KDQpBZGQgdGhpcyBpbmZvcm1hdGlvbiBpbiBjb21taXQgbWVzc2FnZSBzbyBvdGhlcnMg
d291bGQgbm90IGJlIGNvbmZ1c2VkLg0KDQpSZWdhcmRzLA0KQ0sNCg0KPiANCj4gUmVnYXJkcywN
Cj4gU2hhd24NCj4gDQo+ID4gDQo+ID4gUmVnYXJkcywNCj4gPiBDSw0KPiA+IA0KPiA+ID4gKw0K
PiA+ID4gK2lmICgoc3RhdGUtPmJhc2UuZmIgJiYgIXN0YXRlLT5iYXNlLmZiLT5mb3JtYXQtPmhh
c19hbHBoYSkgfHwNCj4gPiA+ICsgICAgc3RhdGUtPmJhc2UucGl4ZWxfYmxlbmRfbW9kZSA9PSBE
Uk1fTU9ERV9CTEVORF9QSVhFTF9OT05FKSB7DQo+ID4gPiAgLyoNCj4gPiA+ICAgKiBNaXhlciBk
b2Vzbid0IHN1cHBvcnQgQ09OU1RfQkxEIG1vZGUsDQo+ID4gPiAgICogdXNlIGEgdHJpY2sgdG8g
bWFrZSB0aGUgb3V0cHV0IGVxdWl2YWxlbnQNCj4gPiA+IEBAIC0xOTEsOCArMTk5LDcgQEAgdm9p
ZCBtdGtfZXRoZHJfbGF5ZXJfY29uZmlnKHN0cnVjdCBkZXZpY2UgKmRldiwNCj4gPiA+IHVuc2ln
bmVkIGludCBpZHgsDQo+ID4gPiAgbXRrX2RkcF93cml0ZShjbWRxX3BrdCwgcGVuZGluZy0+aGVp
Z2h0IDw8IDE2IHwgYWxpZ25fd2lkdGgsDQo+ID4gPiAmbWl4ZXItPmNtZHFfYmFzZSwNCj4gPiA+
ICAgICAgICBtaXhlci0+cmVncywgTUlYX0xfU1JDX1NJWkUoaWR4KSk7DQo+ID4gPiAgbXRrX2Rk
cF93cml0ZShjbWRxX3BrdCwgb2Zmc2V0LCAmbWl4ZXItPmNtZHFfYmFzZSwgbWl4ZXItPnJlZ3Ms
DQo+ID4gPiBNSVhfTF9TUkNfT0ZGU0VUKGlkeCkpOw0KPiA+ID4gLW10a19kZHBfd3JpdGVfbWFz
ayhjbWRxX3BrdCwgYWxwaGFfY29uLCAmbWl4ZXItPmNtZHFfYmFzZSwgbWl4ZXItDQo+ID4gPiA+
IHJlZ3MsIE1JWF9MX1NSQ19DT04oaWR4KSwNCj4gPiA+IA0KPiA+ID4gLSAgIDB4MWZmKTsNCj4g
PiA+ICttdGtfZGRwX3dyaXRlKGNtZHFfcGt0LCBhbHBoYV9jb24sICZtaXhlci0+Y21kcV9iYXNl
LCBtaXhlci0+cmVncywgDQo+ID4gPiBNSVhfTF9TUkNfQ09OKGlkeCkpOw0KPiA+ID4gIG10a19k
ZHBfd3JpdGVfbWFzayhjbWRxX3BrdCwgQklUKGlkeCksICZtaXhlci0+Y21kcV9iYXNlLCBtaXhl
ci0NCj4gPiA+ID4gcmVncywgTUlYX1NSQ19DT04sDQo+ID4gPiANCj4gPiA+ICAgICBCSVQoaWR4
KSk7DQo+ID4gPiAgfQ0KPiA+ID4gDQo+ID4gPiAtLSANCj4gPiA+IEdpdC0xNDYpDQo+ID4gPiAN
Cj4gPiA+IA0KPiA+ID4gDQo=

