Return-Path: <linux-kernel+bounces-169485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44C048BC969
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 10:19:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE48D283AFC
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 08:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 717F01420D1;
	Mon,  6 May 2024 08:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="e7FnVbXP";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="nX5VoXXg"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14C6E1420B9
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 08:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714983569; cv=fail; b=bKIUOphBvZP87ipCKm2Lw7BIyLdiDdtzlXIP9mJJbuoazYv2T7IeBBi4/FC7yyz6mb09VeoTEYaTJCQMizILY3sDTg/t3+SgFKOCFyFUVDbkY3+mCEhlbhD2NRghzQpC5bJum20UpdQMakxBN1xt6sQyVgmOiEgezRhQFCSXihM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714983569; c=relaxed/simple;
	bh=HEeBIAPhIknqAfa9WYo/vwAkQSB5Z2vFALsuS295dM0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=m7Ui78SIZ7NIAAQbzDdnsVYH7NStiq4iunM0/l0GTTjPWty7vo4ZJbAnyEK1Q//vEROZHkf4YFD6RcvmzoVbW32ws9oZf+rp3hOgDX7hjgoUzRpARRIRX2tVAbb6aOPRuUBe85MBv2FHZb0Svi+vJfHKoyw0pozdfrdamc+zSnw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=e7FnVbXP; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=nX5VoXXg; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 534f36cc0b8111ef8065b7b53f7091ad-20240506
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=HEeBIAPhIknqAfa9WYo/vwAkQSB5Z2vFALsuS295dM0=;
	b=e7FnVbXPcekyuaznurPtqT/c1GjrKLUunkdXt7MfbMKwm1CXBIRMUI2uuJ77M7/ImR2Zr4Ze8EGZ1QNF2rDs7k+ITpRLuuI9baFupcK0lZrtX704BLxNFrZ3SgxUfG6CkE3nSfDHwQTDjOLuFc1pDuC/Ksjn+5hOoKzSNOObX5U=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:46cdcf24-89f3-48cb-9b36-0bf21a0043bc,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:82c5f88,CLOUDID:8931bcfb-ed05-4274-9204-014369d201e8,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 534f36cc0b8111ef8065b7b53f7091ad-20240506
Received: from mtkmbs09n2.mediatek.inc [(172.21.101.94)] by mailgw02.mediatek.com
	(envelope-from <gavin.liu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 555997985; Mon, 06 May 2024 16:19:14 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 6 May 2024 16:19:13 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 6 May 2024 16:19:13 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lRKn4gyffwyNNr3pXJQB5DsJRIjHcNad6m+RFF2WawJDFUxN0Jt09V/jyuOKLxYEBwhKOkmc0ls6qjEwl7yXM7Y42kjVIjcrjK9pp/rEQaP9fVpAnERW/72pnWk2Hu+yXuRnyVcSM+SKSBO1UI++0tBfcPLPwKJ1EQs8Gb/ZcPfoKG1FkUvA21ZQ2tEPMnmqpVG569obiyjS8K1WaarL2c1x7DBba+p007tKS0X+LRREs/vn/UAR5jgmaXG8i2E6ToYfGDNpyFlQta+YA+XU0hV431l5Rmgc8DMaxeSMeBXiSsDHXlmNGW7gbc7GqHWQ25EgLjhG/utyxQmmnv4ENg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HEeBIAPhIknqAfa9WYo/vwAkQSB5Z2vFALsuS295dM0=;
 b=VIL9/szUuCFHfzI7Q03cZI+Gf36VKCW25S4VjNkFnGe4VuvzmLNK3Y4Rs72TaiXLYaR8N5runRw3LWwAs+39vUh1E3pIBOEqdOiNybvKmNQhp0cTaRAp4wslIutsToQIX2j0oqfhEI7n+t86SbD9OjBfI4gGzmk1BZJG/FrHwe71EptCwS8sGw3nRO97MVqBLGy5wuN5YwDefsyFglYiD+fMi45KUs4AqtM0IBJYfwmtCvJPiIsqBTiSBobSq5jBYkb8rz1MM1veVG3R8mTE3tIJ1nBC8KgQxs5GTaYTk4wkYGSOuHsbsm52pc/MR+Jyx4WsOr2ZAwRkUl+Qe2l9Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HEeBIAPhIknqAfa9WYo/vwAkQSB5Z2vFALsuS295dM0=;
 b=nX5VoXXgfci3N5xCvXlGmH864JwGf+o/Kq7Hzl9jw3oiEqY2TOZeqgcR0bMrW72/P9KkPh2aPtZ7Y4Am0sIU90gMTOidp23qjpBxOy9iMGnePWWa+EHKo5LTvDrDInQeX9UFcCkvXso09X2i5kvb4APgxNUGyeHwqyitW86qgqo=
Received: from OS8PR03MB8828.apcprd03.prod.outlook.com (2603:1096:604:28b::13)
 by SEZPR03MB8830.apcprd03.prod.outlook.com (2603:1096:101:255::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.40; Mon, 6 May
 2024 08:19:09 +0000
Received: from OS8PR03MB8828.apcprd03.prod.outlook.com
 ([fe80::ac06:c359:5c1e:b2f7]) by OS8PR03MB8828.apcprd03.prod.outlook.com
 ([fe80::ac06:c359:5c1e:b2f7%5]) with mapi id 15.20.7544.041; Mon, 6 May 2024
 08:19:09 +0000
From: =?utf-8?B?R2F2aW4gTGl1ICjlionlk7Llu7cp?= <Gavin.Liu@mediatek.com>
To: "jens.wiklander@linaro.org" <jens.wiklander@linaro.org>
CC: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>, "sumit.garg@linaro.org"
	<sumit.garg@linaro.org>, "op-tee@lists.trustedfirmware.org"
	<op-tee@lists.trustedfirmware.org>
Subject: Re: [PATCH v2] optee: add timeout value to optee_notif_wait() to
 support timeout
Thread-Topic: [PATCH v2] optee: add timeout value to optee_notif_wait() to
 support timeout
Thread-Index: AQHanG6n8dQvj6nG2U+RAE5pDi8RMbGJ2pOAgAAIsQA=
Date: Mon, 6 May 2024 08:19:09 +0000
Message-ID: <a14c567b4528840ab77c9f3faf19afc6c40f62cc.camel@mediatek.com>
References: <20240502085636.4049-1-gavin.liu@mediatek.com>
	 <CAHUa44GGzMQjrkFm4JRQ463wqOpZfzoo91TchK=PdH1Rt565pQ@mail.gmail.com>
In-Reply-To: <CAHUa44GGzMQjrkFm4JRQ463wqOpZfzoo91TchK=PdH1Rt565pQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS8PR03MB8828:EE_|SEZPR03MB8830:EE_
x-ms-office365-filtering-correlation-id: 18197f44-2f2b-4396-9966-08dc6da53465
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?V1Y1OWNkc0VjUFpDV1FDWFV0UFZwNG00cUZlZlgyTk5vYXdXK0dPbnhCSFU5?=
 =?utf-8?B?VEY2bXNHdzRlY3h0UWdudFNtWmNwWXV0MDNyaFlOTlFqZWZubjYzWFlRSmZX?=
 =?utf-8?B?TmJXWW0vNmFEeUxneVJvM05vR1R2OXBGTzFpWERwa0xjQWlKZS92S1pQTFl6?=
 =?utf-8?B?V2NmWTRUQTI2TGgxZzQ5ZXg4R2NHZ2NVNVd1VGJNUzFTTmQycTIvL3BsbWhJ?=
 =?utf-8?B?azFyb3B6cEIxVldwdkxZQUFPRHZIWFJ4YXZPbG1pd1NhaEQwOUl2anpGYUNV?=
 =?utf-8?B?N3lMK3pTVXRHaTh1ZjRtaCtUYm0zMURNMVk3UmJGSHNpMDBOTklEQ1VRRFgv?=
 =?utf-8?B?dGNYK1p2N3k1T1RodmhUemliRDBVRlZLdWRxM0hQSzliWURnZk1QbXB4a1Fo?=
 =?utf-8?B?bm1zMTVGM1lWbEthY29XNS9pWG4yK0FGeFdpL3RXSVloMlZ6VmxNTEZCU0Vx?=
 =?utf-8?B?aXMxYUYza20wYVVBdnVmOHRKRy9SU29RUE1zejE2NTQ4bWtnQW1PMTd0dFZv?=
 =?utf-8?B?Z2RWWEw3cElLckxhTlFTRVBHWHhPUTAvNUViOE1VRWt5aG9hbGc1aVU1ZlhL?=
 =?utf-8?B?aHVGcnNSU0o4c2F3UHR6ZFpuSkMyTU5QcTZHUU9YWlR1M2tqenhaeklsMUdv?=
 =?utf-8?B?NXd5WEgzOWN0ejNPeHRwVVlFNjdja0FSV1lGenhJZGQybllPWWpmSGgrY1Q1?=
 =?utf-8?B?cENmanZUWVBsS1QvYjIwbkQxYzFkbjV1T21waGhNbElTMGdEME9iN2R5ZTVF?=
 =?utf-8?B?VWp1SHlMRmNFbEd2dkU4MGQxb1hFZDEwZmpheXpUMTR6TUZHNWd1cHBCSzdz?=
 =?utf-8?B?WmtSL1VDMXhyY0lVT01qaFNtRWhrUjhOY29ocVY1dVNlYjhhTFRZT2RLYm41?=
 =?utf-8?B?WkJ6dW1TdGY5VkJkU2VoOVg2bXFJRXM4SERwbjBPdW81ZzQzNjNkYVV0Z2p4?=
 =?utf-8?B?L0xjbzJBMWVBTzFOaGdHYjREQWo4Yk5yVnM0bWpNTHZyaW12YWpRRlg2ZXRi?=
 =?utf-8?B?aGo5RVVsbXhHR09MUU5SU1JhNWsvaFU5alFyam1oMGlXWFR5VURqQ2VXa2t4?=
 =?utf-8?B?MU9GVW1WUk1rMHQzbjc2ZUE0WGl6RUJ4R0E4Z1NRQzhEams3M3ZQVXF0cG9K?=
 =?utf-8?B?eStmTzRsZHlwTkRndW9BeXRZYmUwMzRzckl6UXcxRGh0b0RZb1cwQzFvd1Ax?=
 =?utf-8?B?NGkwbzl0cUw3d3Q5b01pUGd4aDRhNXhpTTZKYk5VQloxS2dmREZiUFUzb3cr?=
 =?utf-8?B?UjE0STNxYlJXSGZmNzhlWjU5Rld5ZXJxRUllc2RVYzU0ajNSR2c5SEp0eS9S?=
 =?utf-8?B?L2E4cml5bW15MEZjcm91cWJVYXB2L1haczY5YXpiaUFKVTFER1lNcTl3akIr?=
 =?utf-8?B?YnVnWmd5VDNZK2l4TkF5RUlRU25vMU9VRkxTdEQrSk1vY1FtWHJsM1FXQTlz?=
 =?utf-8?B?U2ZjdUpyemk2ZURQbyttMzZoclNrWmhFcmpTczBLTzErc255ZStZUHZMbngx?=
 =?utf-8?B?RFBWZzdsYVA4QXVXM3FIR296QTcrcUh4L1NSUzFGcUFZVFRTUVZURGx1emxu?=
 =?utf-8?B?RHF0U0xxY0I1MzhwWW5DamlXclNnZzlra0VXRWJnNUZTeXpBREZIb2puUUgy?=
 =?utf-8?B?eHgwR25OY2IyWDR0WTBYWXMzektsTEY1ajB2Tnh3cUhTa2FYSStJSFcrK3Fl?=
 =?utf-8?B?VDBsV1MyVmNqTlptZUtkL2VoTU5xdjlPVkpQZmprZ0VuTWlRMFZBcEJTMm5z?=
 =?utf-8?B?TFVNYjNleU1MZHNJS2xMUnpuR1lqK0gvL29Ga082YS9rL0VWM0dGRmJ4TER0?=
 =?utf-8?B?S3FhQjgrdjBtS2JIYkF0QT09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS8PR03MB8828.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cXIrL2xyMCtIOERhdjVBYzdyL2NTbzlORTJmemhWcUJCL2lETytQRnhZb2Y3?=
 =?utf-8?B?M3Evdkl5WHJuTElWMHN0MjJLMzc4Q3NIQUwreUoydVpTMHU2SVFSU1JEamlu?=
 =?utf-8?B?MG5MeWptakZUVzVDbTMrbEtaRGNSUVcyVllBQW9lK20zZTlMeWhuR1ZpcGZz?=
 =?utf-8?B?M1FwRTl0VWlpQUZpUmFmbDJaTk1CTkl2cjZCcllLbFN4TTVqU2VJQXZtUnFl?=
 =?utf-8?B?UEZGQ2xEaDdaU1E5Q2lzUTVrZUtZYzhwNzRUWTNBaitjbHBGOUM4dWZMYTF6?=
 =?utf-8?B?S2x2c2FCUXZvT0E0QWdGalIrTXQ2bHpOR1ZhNXU3N2g2SUpORnRldGFvajBE?=
 =?utf-8?B?SGovMlhPQ3c5SExyV0Jma2dhRG04T0Q3b1p6YW9RZVhOejJiMWRQbU43RllK?=
 =?utf-8?B?bk10S0xzZk03TlEwUkFUWEZpTm1nbE1LMjR4TVRCUHBGTU9ycmpLaEhpeTdH?=
 =?utf-8?B?NDJ6bzBucHF6dzNvSzJtcklGbDROWWFGNDQ2bUpLa00zYWhjMVRsR2w4My9t?=
 =?utf-8?B?eHcrUzlqdU9ja0NSek11Yng5cUV4aG8weExTLzRJeURjQVoxZ1hNR2JxNGZi?=
 =?utf-8?B?VVp0dGxkSmdnWFBZYk9ER0EvemJhZlhqYVFhUkl2ZnlYdnJJUGZuRVhQSUQ2?=
 =?utf-8?B?dWI1TklZZXNCMXZkSTVYQkZVWGEwd0g0WFNhandkTXE0eVhZQWdLSVY2UkEr?=
 =?utf-8?B?eE1MbFdqMDFzK0g1aG9sLzVxUWN2cVdqRzQ0UjNWNVhOUEJmZ1RSWEFiWWJ3?=
 =?utf-8?B?ZnlIWlRkcjJYQ01pZ3FTcy9zeHF5TGNEeE1yRnZ3enB3T3VoeisyUlUwTmtz?=
 =?utf-8?B?TmJxRVJKcDdWSUVaZEoxMW5YbzdIaUk5MjY5elFpUFFYZUJNanpaWm9KNUNN?=
 =?utf-8?B?Yy9kMGlUZXhncXhTVzBKVmxmZlNZM3AxditnZkxDNjlSb29VZlVEMzlzVnZJ?=
 =?utf-8?B?bjdFOXpGNWdNcll1NVI3WllhTlpqUEFtbGpnUUlJRERZcm1CVzVJaXlhRy9J?=
 =?utf-8?B?Z20wNmxvODRDTEx5YzBIUDVwZGZOMndrcEZQZit5dWJTb0Z0VXdUaXAvSldL?=
 =?utf-8?B?TWpkc0hWQWE3WFRnallEYnNTUVEvSEpFZHB2dWpYUVNWTXdHVm9tM0JyUldx?=
 =?utf-8?B?MlVLWk10eGNYY1FmVm93OXl2M29aazg0KzhHQXlQejNWNmdhOXEwYWswbTk0?=
 =?utf-8?B?WlcyUTE2dW1FNW1WK0YvMWozeXZUeXhKeWlBa2JkZEtIYlM3N2t0OU1jVTY1?=
 =?utf-8?B?RTBOSzc4eERRUUFETXN5c3hQS1V2Q3d1ZktEZjVrUFlONVBpWjZVcDI1M0Nj?=
 =?utf-8?B?WHgxWXNWM2VmU2V5TytQaEpsN1pFRnZSaEJPZXJFamNVTlMzMGpncGVxYTVv?=
 =?utf-8?B?anlsRDYyNnVpUkFhWmxBQmlaSU9jaXc1eUxMdnhZaXovT3JCdUUxZDNON0Nr?=
 =?utf-8?B?dCt2QlZ3NXM4YlVpNGZjNkw4NFlvejFYNVZTRkFWcURwQmlSS3ArTVo5NWF3?=
 =?utf-8?B?RlVSVHZoT1Z3NHkwSkVDbDQ1NFJuWldPSlhyL21lV1Ara21ISktFQVgzbFA0?=
 =?utf-8?B?VmhjVGlPUmVYVERQZEhwajhqdDRKNUs4WmZ1aUNVVWdTVEdUYU5xcXYzWkpS?=
 =?utf-8?B?T1FNM0NhdndtTWs4dU9RQTFYTllaTmVKNVRnajAzNXFlcGFFMTRPdDlqOGtt?=
 =?utf-8?B?SUJsOW4wdkdzZnYwWGxKbURhMkFQZVViUDcxVi8yeGs4MzN0YzVIcGE5RzYr?=
 =?utf-8?B?a1JTeWlRaWxndGVaNHFScyswRmxSNXl3U0ZGTlEraDdOd0hxaEZKUE51MU5o?=
 =?utf-8?B?eW1Qckd3Tzg5OXZOVENyUCtDRTE1RFJlQ3d3Z3hxcHZRYXRpcHdEKzZURXVh?=
 =?utf-8?B?WVJoYjl6VDRBOWowTXlmZmYyQjAvRGtuaGpQQ1FoU25YcWNRWjFMSUE4Ymlp?=
 =?utf-8?B?YVFtYllRK3BYempjemtHWFBkMGhTSEYrVUplelF5b2hCWFJKSGZYWWZGME1B?=
 =?utf-8?B?WGpIZVBuVG1TMmhzbUJHVnFoRlZ5cUJNMWZ6bUxvbXNteHpUS2pITHpITkl5?=
 =?utf-8?B?VndKRzZCYklMR3J1Tzd2M2k4OTNISG1SWjllSmR2eEErRTNQOCtPWmM1SitK?=
 =?utf-8?B?dXIveFFKejZ1QTRPSjFxTG16L1Y1ZTVtSERMU1VUWXZWMVRKR3k2MTR3a29Q?=
 =?utf-8?B?T2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BC3B301A629D4B4E8C60C9D465D23269@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS8PR03MB8828.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18197f44-2f2b-4396-9966-08dc6da53465
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2024 08:19:09.5600
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3epDRecvbSPSoTHhWHkxaPWg2bsKPvNjQJFhtz8vHPDBdZRRzOMD+crqG/C8zSGSptD/DRjVUhoQgmBMs2W+Jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB8830
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--31.978600-8.000000
X-TMASE-MatchedRID: WTos3XtpXXHUL3YCMmnG4omfV7NNMGm+EtdrY/Wb3fNq1n9CrSmVbiZK
	RIFpXA+B1Fc61VCGvh1oYMUHwkc5gHjxgHkp9duCQty8giCJW42r3d1rmRdCgCy4155fUA7Pnav
	y5KjTaan0oTsvScnHSjQdvTJfKQOfwuTfHDVJ/15PuMJi/ZAk8VsChor7BLiNLP7lAJOsT+z5WK
	Feqf3EsayllYROb8WG3ryZvoJpflKFglSdfYqkNxes/RxhysDbh+w9Wz/xXDrzYcyIF7RSVazq3
	VB9mgB3w/XbfgDonR+N/3dDbj3CNasayHn034iUsyNb+yeIRArXof+XRfBH2xxUkJPe1WBqKSyM
	l4Bp7a7Qwl0SKaLKYMqC0noBungtK8hR2zZwSxtNVr4vdmCpzn0tCKdnhB58pTwPRvSoXL2y5/t
	FZu9S3Ku6xVHLhqfxvECLuM+h4RB+3BndfXUhXQ==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--31.978600-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	A11D6BBA79966B912D310C7DD6403406237982001F01AE45E294B3CBC5CCAC932000:8

SGkgSmVucywNCg0KVGhhbmtzIGZvciB0aGUgcmV2aWV3cy4NCg0KT24gTW9uLCAyMDI0LTA1LTA2
IGF0IDA5OjQ4ICswMjAwLCBKZW5zIFdpa2xhbmRlciB3cm90ZToNCj4gIAkgDQo+IEV4dGVybmFs
IGVtYWlsIDogUGxlYXNlIGRvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVu
dGlsDQo+IHlvdSBoYXZlIHZlcmlmaWVkIHRoZSBzZW5kZXIgb3IgdGhlIGNvbnRlbnQuDQo+ICBP
biBUaHUsIE1heSAyLCAyMDI0IGF0IDEwOjU24oCvQU0gZ2F2aW4ubGl1IDxnYXZpbi5saXVAbWVk
aWF0ZWsuY29tPg0KPiB3cm90ZToNCj4gPg0KPiA+IEZyb206IEdhdmluIExpdSA8Z2F2aW4ubGl1
QG1lZGlhdGVrLmNvbT4NCj4gPg0KPiA+IEFkZCB0aW1lb3V0IHZhbHVlIHRvIHN1cHBvcnQgc2Vs
ZiB3YWtpbmcgd2hlbiB0aW1lb3V0IHRvIGF2b2lkDQo+IHdhaXRpbmcNCj4gPiBpbmRlZmluaXRl
bHkuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBHYXZpbiBMaXUgPGdhdmluLmxpdUBtZWRpYXRl
ay5jb20+DQo+ID4gLS0tDQo+ID4gQ2hhbmdlIGluIHYyOg0KPiA+IENoYW5nZSBjb21taXQgbWVz
c2FnZS4NCj4gPiBBZGQgZGVzY3JpcHRpb24gZm9yIHZhbHVlWzBdLmMgaW4gb3B0ZWVfcnBjX2Nt
ZC5oLg0KPiA+IC0tLQ0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL3RlZS9vcHRlZS9ub3RpZi5jICAg
ICAgICAgfCAgOSArKysrKysrLS0NCj4gPiAgZHJpdmVycy90ZWUvb3B0ZWUvb3B0ZWVfcHJpdmF0
ZS5oIHwgIDIgKy0NCj4gPiAgZHJpdmVycy90ZWUvb3B0ZWUvb3B0ZWVfcnBjX2NtZC5oIHwgIDEg
Kw0KPiA+ICBkcml2ZXJzL3RlZS9vcHRlZS9ycGMuYyAgICAgICAgICAgfCAxMCArKysrKysrKy0t
DQo+ID4gIDQgZmlsZXMgY2hhbmdlZCwgMTcgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkN
Cj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3RlZS9vcHRlZS9ub3RpZi5jIGIvZHJpdmVy
cy90ZWUvb3B0ZWUvbm90aWYuYw0KPiA+IGluZGV4IDA1MjEyODQyYjBhNS4uZDVlNWMwNjQ1NjA5
IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvdGVlL29wdGVlL25vdGlmLmMNCj4gPiArKysgYi9k
cml2ZXJzL3RlZS9vcHRlZS9ub3RpZi5jDQo+ID4gQEAgLTI5LDcgKzI5LDcgQEAgc3RhdGljIGJv
b2wgaGF2ZV9rZXkoc3RydWN0IG9wdGVlICpvcHRlZSwgdV9pbnQNCj4ga2V5KQ0KPiA+ICAgICAg
ICAgcmV0dXJuIGZhbHNlOw0KPiA+ICB9DQo+ID4NCj4gPiAtaW50IG9wdGVlX25vdGlmX3dhaXQo
c3RydWN0IG9wdGVlICpvcHRlZSwgdV9pbnQga2V5KQ0KPiA+ICtpbnQgb3B0ZWVfbm90aWZfd2Fp
dChzdHJ1Y3Qgb3B0ZWUgKm9wdGVlLCB1X2ludCBrZXksIHUzMiB0aW1lb3V0KQ0KPiA+ICB7DQo+
ID4gICAgICAgICB1bnNpZ25lZCBsb25nIGZsYWdzOw0KPiA+ICAgICAgICAgc3RydWN0IG5vdGlm
X2VudHJ5ICplbnRyeTsNCj4gPiBAQCAtNzAsNyArNzAsMTIgQEAgaW50IG9wdGVlX25vdGlmX3dh
aXQoc3RydWN0IG9wdGVlICpvcHRlZSwgdV9pbnQNCj4ga2V5KQ0KPiA+ICAgICAgICAgICogVW5s
b2NrIHRlbXBvcmFyaWx5IGFuZCB3YWl0IGZvciBjb21wbGV0aW9uLg0KPiA+ICAgICAgICAgICov
DQo+ID4gICAgICAgICBzcGluX3VubG9ja19pcnFyZXN0b3JlKCZvcHRlZS0+bm90aWYubG9jaywg
ZmxhZ3MpOw0KPiA+IC0gICAgICAgd2FpdF9mb3JfY29tcGxldGlvbigmZW50cnktPmMpOw0KPiA+
ICsgICAgICAgaWYgKHRpbWVvdXQgIT0gMCkgew0KPiA+ICsgICAgICAgICAgICAgICBpZiAoIXdh
aXRfZm9yX2NvbXBsZXRpb25fdGltZW91dCgmZW50cnktPmMsDQo+IHRpbWVvdXQpKQ0KPiA+ICsg
ICAgICAgICAgICAgICAgICAgICAgIHJjID0gLUVUSU1FRE9VVDsNCj4gPiArICAgICAgIH0gZWxz
ZSB7DQo+ID4gKyAgICAgICAgICAgICAgIHdhaXRfZm9yX2NvbXBsZXRpb24oJmVudHJ5LT5jKTsN
Cj4gPiArICAgICAgIH0NCj4gPiAgICAgICAgIHNwaW5fbG9ja19pcnFzYXZlKCZvcHRlZS0+bm90
aWYubG9jaywgZmxhZ3MpOw0KPiA+DQo+ID4gICAgICAgICBsaXN0X2RlbCgmZW50cnktPmxpbmsp
Ow0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3RlZS9vcHRlZS9vcHRlZV9wcml2YXRlLmgNCj4g
Yi9kcml2ZXJzL3RlZS9vcHRlZS9vcHRlZV9wcml2YXRlLmgNCj4gPiBpbmRleCA3YTUyNDNjNzhi
NTUuLmRhOTkwYzQwMTZlYyAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL3RlZS9vcHRlZS9vcHRl
ZV9wcml2YXRlLmgNCj4gPiArKysgYi9kcml2ZXJzL3RlZS9vcHRlZS9vcHRlZV9wcml2YXRlLmgN
Cj4gPiBAQCAtMjUyLDcgKzI1Miw3IEBAIHN0cnVjdCBvcHRlZV9jYWxsX2N0eCB7DQo+ID4NCj4g
PiAgaW50IG9wdGVlX25vdGlmX2luaXQoc3RydWN0IG9wdGVlICpvcHRlZSwgdV9pbnQgbWF4X2tl
eSk7DQo+ID4gIHZvaWQgb3B0ZWVfbm90aWZfdW5pbml0KHN0cnVjdCBvcHRlZSAqb3B0ZWUpOw0K
PiA+IC1pbnQgb3B0ZWVfbm90aWZfd2FpdChzdHJ1Y3Qgb3B0ZWUgKm9wdGVlLCB1X2ludCBrZXkp
Ow0KPiA+ICtpbnQgb3B0ZWVfbm90aWZfd2FpdChzdHJ1Y3Qgb3B0ZWUgKm9wdGVlLCB1X2ludCBr
ZXksIHUzMiB0aW1lb3V0KTsNCj4gPiAgaW50IG9wdGVlX25vdGlmX3NlbmQoc3RydWN0IG9wdGVl
ICpvcHRlZSwgdV9pbnQga2V5KTsNCj4gPg0KPiA+ICB1MzIgb3B0ZWVfc3VwcF90aHJkX3JlcShz
dHJ1Y3QgdGVlX2NvbnRleHQgKmN0eCwgdTMyIGZ1bmMsIHNpemVfdA0KPiBudW1fcGFyYW1zLA0K
PiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3RlZS9vcHRlZS9vcHRlZV9ycGNfY21kLmgNCj4gYi9k
cml2ZXJzL3RlZS9vcHRlZS9vcHRlZV9ycGNfY21kLmgNCj4gPiBpbmRleCBmM2YwNmUwOTk0YTcu
Ljk5MzQyYWE2NjI2MyAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL3RlZS9vcHRlZS9vcHRlZV9y
cGNfY21kLmgNCj4gPiArKysgYi9kcml2ZXJzL3RlZS9vcHRlZS9vcHRlZV9ycGNfY21kLmgNCj4g
PiBAQCAtNDEsNiArNDEsNyBAQA0KPiA+ICAgKiBXYWl0aW5nIG9uIG5vdGlmaWNhdGlvbg0KPiA+
ICAgKiBbaW5dICAgIHZhbHVlWzBdLmEgICAgICBPUFRFRV9SUENfTk9USUZJQ0FUSU9OX1dBSVQN
Cj4gPiAgICogW2luXSAgICB2YWx1ZVswXS5iICAgICAgbm90aWZpY2F0aW9uIHZhbHVlDQo+ID4g
KyAqIFtpbl0gICAgdmFsdWVbMF0uYyAgICAgIHRpbWVvdXQgaW4gbWlsbGlzZWNvbmQgb3IgMCBp
ZiBubw0KPiB0aW1lb3V0DQo+IA0KPiBtaWxsaXNlY29uZHMNCg0KT2ssIEknbGwgY2hhbmdlIGl0
Lg0KDQo+IA0KPiA+ICAgKg0KPiA+ICAgKiBTZW5kaW5nIGEgc3luY2hyb25vdXMgbm90aWZpY2F0
aW9uDQo+ID4gICAqIFtpbl0gICAgdmFsdWVbMF0uYSAgICAgIE9QVEVFX1JQQ19OT1RJRklDQVRJ
T05fU0VORA0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3RlZS9vcHRlZS9ycGMuYyBiL2RyaXZl
cnMvdGVlL29wdGVlL3JwYy5jDQo+ID4gaW5kZXggZTY5YmM2MzgwNjgzLi4xNGU2MjQ2YWFmMDUg
MTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy90ZWUvb3B0ZWUvcnBjLmMNCj4gPiArKysgYi9kcml2
ZXJzL3RlZS9vcHRlZS9ycGMuYw0KPiA+IEBAIC0xMzAsNiArMTMwLDggQEAgc3RhdGljIHZvaWQN
Cj4gaGFuZGxlX3JwY19mdW5jX2NtZF9pMmNfdHJhbnNmZXIoc3RydWN0IHRlZV9jb250ZXh0ICpj
dHgsDQo+ID4gIHN0YXRpYyB2b2lkIGhhbmRsZV9ycGNfZnVuY19jbWRfd3Eoc3RydWN0IG9wdGVl
ICpvcHRlZSwNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCBv
cHRlZV9tc2dfYXJnICphcmcpDQo+ID4gIHsNCj4gPiArICAgICAgIGludCByYyA9IDA7DQo+ID4g
Kw0KPiA+ICAgICAgICAgaWYgKGFyZy0+bnVtX3BhcmFtcyAhPSAxKQ0KPiA+ICAgICAgICAgICAg
ICAgICBnb3RvIGJhZDsNCj4gPg0KPiA+IEBAIC0xMzksNyArMTQxLDggQEAgc3RhdGljIHZvaWQg
aGFuZGxlX3JwY19mdW5jX2NtZF93cShzdHJ1Y3Qgb3B0ZWUNCj4gKm9wdGVlLA0KPiA+DQo+ID4g
ICAgICAgICBzd2l0Y2ggKGFyZy0+cGFyYW1zWzBdLnUudmFsdWUuYSkgew0KPiA+ICAgICAgICAg
Y2FzZSBPUFRFRV9SUENfTk9USUZJQ0FUSU9OX1dBSVQ6DQo+ID4gLSAgICAgICAgICAgICAgIGlm
IChvcHRlZV9ub3RpZl93YWl0KG9wdGVlLCBhcmctDQo+ID5wYXJhbXNbMF0udS52YWx1ZS5iKSkN
Cj4gPiArICAgICAgICAgICAgICAgcmMgPSBvcHRlZV9ub3RpZl93YWl0KG9wdGVlLCBhcmctDQo+
ID5wYXJhbXNbMF0udS52YWx1ZS5iLCBhcmctPnBhcmFtc1swXS51LnZhbHVlLmMpOw0KPiA+ICsg
ICAgICAgICAgICAgICBpZiAocmMpDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgZ290byBi
YWQ7DQo+ID4gICAgICAgICAgICAgICAgIGJyZWFrOw0KPiA+ICAgICAgICAgY2FzZSBPUFRFRV9S
UENfTk9USUZJQ0FUSU9OX1NFTkQ6DQo+ID4gQEAgLTE1Myw3ICsxNTYsMTAgQEAgc3RhdGljIHZv
aWQgaGFuZGxlX3JwY19mdW5jX2NtZF93cShzdHJ1Y3QNCj4gb3B0ZWUgKm9wdGVlLA0KPiA+ICAg
ICAgICAgYXJnLT5yZXQgPSBURUVDX1NVQ0NFU1M7DQo+ID4gICAgICAgICByZXR1cm47DQo+ID4g
IGJhZDoNCj4gPiAtICAgICAgIGFyZy0+cmV0ID0gVEVFQ19FUlJPUl9CQURfUEFSQU1FVEVSUzsN
Cj4gPiArICAgICAgIGlmIChyYyA9PSAtRVRJTUVET1VUKQ0KPiA+ICsgICAgICAgICAgICAgICBh
cmctPnJldCA9IFRFRUNfRVJST1JfQlVTWTsNCj4gDQo+IFRFRUNfRVJST1JfQlVTWSBpcyBjb25m
dXNpbmcuIEhvdyBhYm91dCBURUVfRVJST1JfVElNRU9VVD8gV2UNCj4gbm9ybWFsbHkNCj4gb25s
eSB1c2UgVEVFQ19YWFggZXJyb3IgY29kZXMsIGJ1dCBHUCBkb2Vzbid0IGRlZmluZSBhDQo+IFRF
RUNfRVJST1JfVElNRU9VVCBzbyBpdCdzIGJldHRlciB0byB1c2UgdGhlIEdQLWRlZmluZWQNCj4g
VEVFX0VSUk9SX1RJTUVPVVQuDQo+IA0KPiBDaGVlcnMsDQo+IEplbnMNCj4gDQoNCkFncmVlZCwg
d2UgYWxzbyB1c2UgVEVFX0VSUk9SX1RJTUVPVVQgaW4gdGhlIGNvcnJlc3BvbmRpbmcgcGF0Y2gg
Zm9yDQpvcHRlZS1vcy4gQnV0LCB0aGUgIlRFRV9FUlJPUl9USU1FT1VUIiBpcyBjdXJyZW50bHkg
dW5kZWZpbmVkIGluIExpbnV4DQpLZXJuZWwuIERvIHlvdSBoYXZlIGEgc3VnZ2VzdGlvbiBmb3Ig
d2hpY2ggaGVhZGVyIHdvdWxkIGJlIGJldHRlciB0bw0KcGxhY2UgaXQgaW4/DQoNClJlZ2FyZHMs
DQpHYXZpbi5MaXUNCg0KPiA+ICsgICAgICAgZWxzZQ0KPiA+ICsgICAgICAgICAgICAgICBhcmct
PnJldCA9IFRFRUNfRVJST1JfQkFEX1BBUkFNRVRFUlM7DQo+ID4gIH0NCj4gPg0KPiA+ICBzdGF0
aWMgdm9pZCBoYW5kbGVfcnBjX2Z1bmNfY21kX3dhaXQoc3RydWN0IG9wdGVlX21zZ19hcmcgKmFy
ZykNCj4gPiAtLQ0KPiA+IDIuMTguMA0KPiA+DQo=

