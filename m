Return-Path: <linux-kernel+bounces-436668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AFB89E8936
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 03:32:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0CD31885881
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 02:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D73B6433BE;
	Mon,  9 Dec 2024 02:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="U13iz9wi";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="uiYsFSjB"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ECB6BA45;
	Mon,  9 Dec 2024 02:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733711542; cv=fail; b=q+lmcfKP4kp2sYTzbapWrUIzdpEUq6l/oJdLrxiSxwWbAY350JyalBzy5LfIEflCG1AVZQpiitG74l9Y+0/boHa+P67Wq/xjctglYFIEEx5MLK7Ad8dsidVGmYU9Wn2InRfGy3iKHl4JKjOyneb8zJKJL4b8wvJeygi/ZQusUOE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733711542; c=relaxed/simple;
	bh=TCwS3IpNUR+GM81l6QK017kq31JnvZCBMvdpJau37B0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mfbYWChic3rpl3hu7XdRbElPjFc7lpuGUXw5cQgaS2WixVOmz8CjNFB/PJ2YG7EH96+EcbuBBoeRyJ1hGFlDpIdi9qOUtdkrKIRaKh2Gqi4OpDqXHn6oFRtwPxdT86J6oh9RuFfKzsq6s6euwA5GD5UDIPcbiI//upoyRpeM++s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=U13iz9wi; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=uiYsFSjB; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: cd609812b5d511ef99858b75a2457dd9-20241209
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=TCwS3IpNUR+GM81l6QK017kq31JnvZCBMvdpJau37B0=;
	b=U13iz9wiE1flzqe8acpAOGxHoo4EnUHSSxS7RubOyxmdcnNGz01EYxMG2ahPJOeBsycMIH5skGANUAaBVij8wjId7mOOjXYC+sw5HfAPEGtZtC7TFJ8DH7vilwOZukBun7OADgJQZxO/qcPietDBd7D5v8mpGhg5kSwcFy3L+Yc=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:de5b754c-4113-4054-9f40-b7e06d2e7544,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6493067,CLOUDID:9fc3a33b-e809-4df3-83cd-88f012b9e9ba,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0,EDM
	:-3,IP:nil,URL:1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0
	,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: cd609812b5d511ef99858b75a2457dd9-20241209
Received: from mtkmbs09n2.mediatek.inc [(172.21.101.94)] by mailgw01.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1155968064; Mon, 09 Dec 2024 10:32:15 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS14N2.mediatek.inc (172.21.101.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 9 Dec 2024 10:32:13 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 9 Dec 2024 10:32:13 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m27RV3OU2eYdxofHt5nwHfN5nKpBLneJQ/ZXlrzKHCXexJAMI+T9BrToNh0sXpQApFTggSOV3lwZ9ASblk+ovhskntFnUzFf1D/Q9BUoSwvQxHXCIjbuvTSbe/vq3sAk/Y/KSKr3llkuHdrgvQw9VsDSzAwo2mE6gR7zbhXjmeoMxVryVkXK1LNY3ZMemM1gdLiojajppgf7a1ke/jOIrZKlUhX3MK+snFG5lnpfC0RngLHTwepfD9T/ksmDrVGR0yd8mjl0si7QZQxebcnEWFChFh6RlWWcd0QiROTpF8dogdWvfHSnIrelh/STWzj5jtyYReRAayYv3QKq5smSIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TCwS3IpNUR+GM81l6QK017kq31JnvZCBMvdpJau37B0=;
 b=v+fjybuQsGE/aewR2pKGf7PHZvz/3pygt75ZccIy74akce1DAnb5yyu1mvCRU0PmMZmaQt3zfVSUzFDpD6SwcZGswe83VcOWOkfPhs6I2sfR4bcbJDc9VQIldaw09bb7552wDYRMz+T5fhAyXuEno8/pDl7zaUqzexX5AdCUZ0XnPnCgGC3W7jxhQ9TFj7avgSD4ksmmxEhHOw/r/QcLqu8APz30kf752/dSnN8k+xYt87XvI7lBZJgSL/H1khGMTo0YDJ9PzaZnXHj6zsCkOoeRobszPsCI7gVXUS6yMXqhgYr+FMv1JsaBAWORypS0o5VasW62zFbs5yXavkuToA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TCwS3IpNUR+GM81l6QK017kq31JnvZCBMvdpJau37B0=;
 b=uiYsFSjB7om8Tk+F/tnMRkGiuMSgEqJJniE+fce20KIJJ/8Uw1KpGXJ5z9nePXKdQIMNM8X2DyHdW1xOvQnm+RJJL3PS+gsL7eLzKUO1rlAxkxIxR69HQiKqhT94SUJBlVoSQYL8xzXkhM5/JDIDPwdBbXak8qjzetGmSHGvhkE=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by KL1PR03MB6974.apcprd03.prod.outlook.com (2603:1096:820:b8::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.24; Mon, 9 Dec
 2024 02:32:08 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54%3]) with mapi id 15.20.8207.014; Mon, 9 Dec 2024
 02:32:08 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>
CC: "robh@kernel.org" <robh@kernel.org>, "jie.qiu@mediatek.com"
	<jie.qiu@mediatek.com>, "tzimmermann@suse.de" <tzimmermann@suse.de>,
	"simona@ffwll.ch" <simona@ffwll.ch>, "mripard@kernel.org"
	<mripard@kernel.org>, =?utf-8?B?Sml0YW8gU2hpICjnn7PorrDmtpsp?=
	<jitao.shi@mediatek.com>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>, "dri-devel@lists.freedesktop.org"
	<dri-devel@lists.freedesktop.org>, "maarten.lankhorst@linux.intel.com"
	<maarten.lankhorst@linux.intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "kernel@collabora.com" <kernel@collabora.com>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "p.zabel@pengutronix.de"
	<p.zabel@pengutronix.de>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"airlied@gmail.com" <airlied@gmail.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "junzhi.zhao@mediatek.com"
	<junzhi.zhao@mediatek.com>
Subject: Re: [PATCH v2 06/15] drm/mediatek: Add support for MT8195 Digital
 Parallel Interface
Thread-Topic: [PATCH v2 06/15] drm/mediatek: Add support for MT8195 Digital
 Parallel Interface
Thread-Index: AQHbRwt+JFlpXLoizECUylyf+chlCbLdNv2A
Date: Mon, 9 Dec 2024 02:32:08 +0000
Message-ID: <002104ebc3006169f9ca380422a1b249b5076301.camel@mediatek.com>
References: <20241205114518.53527-1-angelogioacchino.delregno@collabora.com>
	 <20241205114518.53527-7-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20241205114518.53527-7-angelogioacchino.delregno@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|KL1PR03MB6974:EE_
x-ms-office365-filtering-correlation-id: 56e4255a-6173-4a18-f3e2-08dd17f9ad81
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|7053199007|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?ek1hVXptTGIreEw0WTkybHhUdnczaE1vbVg3UXFXRld4M3N6UW1TWVYvTGIz?=
 =?utf-8?B?VG42aEY1ZVVORys4V0xQN2trMWxvS1pCcEsxWEJ4dFNMUVk1SFRWM0UzMitL?=
 =?utf-8?B?a1RkZHhuekxBRW5uQXZpNWNFQmNUdW40RVJXMDQwd1pWNWtoYyttUFI3TVEw?=
 =?utf-8?B?ejBPaHlFaDl3aGZsR3EycWFpK0VRT2U4VEJsNEZDUW5ZVC9ZbUhVaDVHNjNW?=
 =?utf-8?B?MWh2N1dUTWZCcXF4VktyQ3A3L2lOejA1YTBsdDFOREREVzRpQWdRTm96Yjdv?=
 =?utf-8?B?N1ErWmhtQkpxS3VCeXZLU2JNVUdSTUsyN1ZJWjZQUHdtOFBHanFJUndoamZY?=
 =?utf-8?B?ZmVEMzBrQk40QmI5ZG4vQkZoZ1p0bW5PMDAxWmx4Q1F2RWI5Z1ZzaEpuMEZI?=
 =?utf-8?B?TmtaQmdwVTBuUFRLWHMxc0YwclIvRE5hVmRTTUxCNGk3Q09ibmJYYmcyNnBB?=
 =?utf-8?B?RVZJMzhleG1GMHZMMTFVU3BUa2xET3RmWUZUS1F1NytEL3NxVnp1cmV0cFUv?=
 =?utf-8?B?SWFPVDB4a3d6L24yUk9vc2NqTWJNS1pHbi84ZTlRRmltUjZpQUZFUCtOT3A1?=
 =?utf-8?B?WDRaaWRsZyttcUF3NUhxNTBtbFVlTEtwZUVzZTNIWm1nTk4yQms5UlZ2cmtD?=
 =?utf-8?B?amJ6eGlpaUlIdTZXbzRlM3lWd045Nm5STER1aG8rVUo3RThLUXFMUUh4L1Zq?=
 =?utf-8?B?TEIzdHJ0TzQ2ZEVOWDJyZ3g5VStTdDd0dlNyM2ZaM2E1KzVJUlFqcndKQ0N1?=
 =?utf-8?B?QVAxUEZobEVZb09Dc00wb3R5ZWpZbkMzWDZicEMzaWFIRWVMb0ozNXh0c1hQ?=
 =?utf-8?B?ZG5WZnVWdEMrdHhOcTRLZk9RMjdReDl0S3VhVVR0WTFua0d5RVdZZ09kaW50?=
 =?utf-8?B?dm44ejlQU2hEM1FEd3Z1d00xbm5IYW1pZkhXOEdUVWdwV2ZMbktVRmpzRWxI?=
 =?utf-8?B?VUFOZEtzUlJjVGUwMHd4cGUvemdyL25SYllYQVhHVnlBaUxCR0VlenFkc3B4?=
 =?utf-8?B?a1JGYVVURjV3WjlOdHUwV0pqaDcxWWtJTU5JdVhlQng3QkVWemtaWlFVOW9H?=
 =?utf-8?B?VUNkbUNmTlZnM0s4Y2xUaDZZVnp0eWdPMllRUkM0c1lyZldrbXAzbTkyc1pT?=
 =?utf-8?B?R2l2d1VMejZnMWtoV29PTmJ0Rk9NK0s0QVJzSU9zSTF3bnFIdkV4SUV6N05F?=
 =?utf-8?B?OThzNU9OZ0NtTnBRL25QVzkwRzg2blZ6cURXcXUwcDgvVE5ocmpjZlFzL0RI?=
 =?utf-8?B?VG8rZ2dqelFjVkZyS3czS2hXUjN4bEJIOVFVeVd0VUJFaTlkUWxXekVGd210?=
 =?utf-8?B?anNlVnBRNWdFQSthSTAwMUxkZ2VzQWlJRzRPckJMYmp5WnVSY0RxWTAvY0hQ?=
 =?utf-8?B?eUU3RjJCQkNXb043dHRJa2cxMnVuNnZzQVhLakdYcDR0OENuMmN3SENFN2RG?=
 =?utf-8?B?YlkwR2VxaFR0RXZFUENFNjFUb09iTTNFRTNNNFhrNmRPc1ptQmI3QjUxRzZX?=
 =?utf-8?B?eVM0aU5HY1JqY2NnQzRxSk44bmQvS3NDRnBFeHlvZXVYYXJUeWxCRmxjdnhk?=
 =?utf-8?B?MVdJU2c1MU9XWTJjeGlHL3d4WitJWmFmRC9NM3ZLRktReFk1MGUySDIzbFR1?=
 =?utf-8?B?WVo4dnA5T3JyTm5NeXp2YTRxbG5nS0RFQ3FXdUFkQ1FSNVo0c2UwZGpUSzZE?=
 =?utf-8?B?MWZZSXVXSmo2T1crL2dmZHRUQVFRVVdzN0VHOCtYTXgwZXlJWU04TGlldW41?=
 =?utf-8?B?VUFWWDZ6TFdyMlNpS1d4VG16R2JyQ2VHSUNhRzJISmhFaEN3bWlKVEtHMjVQ?=
 =?utf-8?B?WUZGbC90YW03Ty9NbUlSanF3QjlJNUlqREpJcm95VXlGRHBCd3N0dWRvVTd6?=
 =?utf-8?B?a2hXOXZ3NCtPeUZ0L0FBRkhMc2duTytTM25pM2dUZ2tnNmc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NkVpZ25FVjNZY1k4b0EzMXdCV0JkNlBZdGprVGdrMU5uc3I4dGpBS3ZLRFdo?=
 =?utf-8?B?bVNzU3l0MkJNR2RhQTREbk9TbVdiZHJOTkZ4bW1SSyt5anRFaHVLWUgzWHd6?=
 =?utf-8?B?aE9jcVJIaTk1dXVFQ0dvdW1PRWNIVWpndnAvQXdjcU1sZ2hDWjZkRERzYUR6?=
 =?utf-8?B?RjF0RzF4OHAyVVJkZzdJR0I1ajB4OVFRN0greVROdUdkN1Mrbk1rejRKTlpO?=
 =?utf-8?B?cVBXeU1qUnBBMSt5eHg2NmlBMFFFcjNrZVF4dklaR0t5ZU45SXlXQ0UraUlU?=
 =?utf-8?B?T0VaV2dGbXVSa3I4S2c2Y1lJRjFzejkyTTlKWkRUZVpUT1M2ekliUzQ3L3dW?=
 =?utf-8?B?NTBhMXFQRmg0RVpER0EzK0xCMjl5dk5lTkhPSUFqaStNdElrSmwrZTFTb3ln?=
 =?utf-8?B?bURqajdQTE1SUVZ5RjdMbzdVazRyMUEwbVJKT2Nwb1pjNG9wNHIvSGlqV05s?=
 =?utf-8?B?QnYreGhFN2MwTzJEQUFPbW1XWkhkeldNUG1NeUV5OEMyTWZNRDVuU3VQQmUy?=
 =?utf-8?B?N2NiWVRnYllqbFFZeGEyWVlVaEN6SGpJTk55ZTdtR3RkUTNEYkw0aEpBZC9L?=
 =?utf-8?B?NHBYeTVXTGpSK3owYWllNkgwU1dCUzVvYzQzeE9ST0RUSWhoRGtJbjNzWDIx?=
 =?utf-8?B?T0RMbWVLYjZhZUh3RmJ5cGo2M1gwSEFKZnZrbE94bkF5emt0MTU5RCtoV0Qv?=
 =?utf-8?B?RXlzaTJUNStUeU5lWEFJallleVhhSEFhZjZOUStGT2JQSTlKZWdLNVpQSDBj?=
 =?utf-8?B?eUYxcVRiVW1Tbk5FemxtTW5xeG04VzV5cDdyNDlvcEMwdnlPbmVmSlRiYlk5?=
 =?utf-8?B?MFBvdnRiMHJzNVlkT3BMZmwyYlNlYlZGb2dPSTRVZkpydXNlUnV2UjNEWGht?=
 =?utf-8?B?L09ZOUl2Y2M2SG84NGNjbUJhUGRwcUp0Y0UzNkRTa21yWEJqUXJpU1BFWnVS?=
 =?utf-8?B?S25qT1hIY0sra0NFRE9GSkFPUUhRbGc2Qkc0Q1B5a0hJRVdBVG10MC9aNVFU?=
 =?utf-8?B?S3FsSWk5RWZhTzB4RTlEUDRxUi9WZEt2dDBLWEZxTDNlTVcrNkRjZDBJM0pp?=
 =?utf-8?B?cGh4cExhYWhnVkxrcUtXaEFaWjJmNXNRamJnTHFBWUJ0cCtJdXU4WTU1YzY5?=
 =?utf-8?B?NWY5cDRyZ2EvRFhPa3VHVjlyRVVYYkpuZjlWbXJ1aVp4MHB2MkY3UWpQVjNy?=
 =?utf-8?B?TVRvTE5qSE9EeWxLMUl0Uitzd241dlFJREFjdm5FbjVkVGNDYWowNDdQTzZu?=
 =?utf-8?B?bGU3Mm5UT2JyQ1JWbjhkYTZYaFhlYzZ2SDF5d0UrektGMUtMOElCZmI5K1Zl?=
 =?utf-8?B?QU5MdHpya3daK25POHNBU2dwenlTYnVFa2RUSFphTzZHa0FOZEVDbFNhcyts?=
 =?utf-8?B?QzJWYzFCSittYW9lY2s5K2ZtTWltaEcwUmF6MnlZalVQa25zaVdybUxwdWdS?=
 =?utf-8?B?UVRLMXI0WUtSMnFaS3Bpemtlc0FUaDh6VE9SY1UwOVh4cmRzLzMwMjdyQVpl?=
 =?utf-8?B?SDZ2TlFOa3ZCQWtpU29TMWlmVjNqTUoxZlRqcFA4UDduK3M0RTVkbXBSbG9X?=
 =?utf-8?B?VXJ6bmREbnZ3bGNJc0wyN1R2Y253RXJFQ00xQzJkZ09UM29MWTAzaERJUWlY?=
 =?utf-8?B?a1o4ZGpsU25oMUNsVjZhWmh6d0J4QzcrZ0IyVnpOSjVWWW14VWF6dng2a3Ev?=
 =?utf-8?B?azM2d1l1ZHFuOWRJcTg2bGd6VUVUSE5CS1VQQ0U1WFZxS2cwSUFvT0dtYUFX?=
 =?utf-8?B?dnZQbThpYVM5VzdyU3FKczhYTTVVbDFFWEFMQTE0dnQxaSsrTWVoc2dFa3k5?=
 =?utf-8?B?WlRMTytEWG1oeFdicmZEeW1yd3FHUkFSWGhWUjM4U2dqazZrcjFzaVZOK3d3?=
 =?utf-8?B?VDI1ZGZxWFE5VW5ITkZINFVwSlhOMHF5TzZzKzBsYTYwUlJWTXlpSGM3RzM5?=
 =?utf-8?B?MFREb0RRK21ORGdkeVlQc0ZiQUlQSGFRZHFURXIxSzlhVDFTbm9TUzVZSGxB?=
 =?utf-8?B?NDNjcEZ4V2hBK29rSzFodjVwL04xUzBGUmRSWUhRaCtCVUcyT3hqUFRSY3BW?=
 =?utf-8?B?Y3VZRjhIK29Kc0dqS2krUDRHMkNkZ2lzM2dVbDhVdVdXaTFLbU9wSkY0RTNL?=
 =?utf-8?Q?Laff2mga2cYUJbw+UGaHHpxQR?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <03E79D77781B3D458A73DC2C74D9B555@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56e4255a-6173-4a18-f3e2-08dd17f9ad81
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Dec 2024 02:32:08.1145
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a/BmDeTCmPTcDKy9QBS/Jb2QVrjWOmbeLOflh/rI+JT3V9FrssCxvF1pYgCdCOaeRyp2FmXrKVQ0EmJXQfu57Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB6974
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--19.327400-8.000000
X-TMASE-MatchedRID: 8+bhjh9TQnENtKv7cnNXnSa1MaKuob8PCJpCCsn6HCHBnyal/eRn3gzR
	CsGHURLuwpcJm2NYlPAF6GY0Fb6yCsME2BsoiKJMSEQN/D/3cG4+WWrj7s+ynxHfiujuTbeddd3
	vE6bWkcFgA13cmle3WR9rlcPkoXFmJBVW14/3QK0D2WXLXdz+AUuDrbFsAPqFmZtXZmEokAtcUW
	Qc9/E0r97DBbB0pSnHiy7rKIegxqNnPzp+oCPs8w5KPhGIg0MRWjWsWQUWzVoICvU2ldz9nElZP
	Fl1UYSMo+jhrasS9zUM5Ark1ZMpEPQPRH4blNMcHPYwOJi6PLmuiRuR9mCauhS11FlOYRoheE02
	QNNEBFPi8zVgXoAltj2Xsf5MVCB1t7DW3B48kkHdB/CxWTRRuyUIayx+Skid
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--19.327400-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	4C2571664F53750DC6BC7FDD7D8A149B7BDFAC103EC6109030118A011E7F76192000:8

SGksIEFuZ2VsbzoNCg0KT24gVGh1LCAyMDI0LTEyLTA1IGF0IDEyOjQ1ICswMTAwLCBBbmdlbG9H
aW9hY2NoaW5vIERlbCBSZWdubyB3cm90ZToNCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8g
bm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW50aWwgeW91IGhhdmUgdmVyaWZp
ZWQgdGhlIHNlbmRlciBvciB0aGUgY29udGVudC4NCj4gDQo+IA0KPiBBZGQgc3VwcG9ydCBmb3Ig
dGhlIERQSSBibG9jayBmb3VuZCBpbiB0aGUgTVQ4MTk1IGFuZCBNVDgxODggU29Dcy4NCj4gSW5z
aWRlIG9mIHRoZSBTb0MsIHRoaXMgYmxvY2sgaXMgZGlyZWN0bHkgY29ubmVjdGVkIHRvIHRoZSBI
RE1JIElQLg0KDQpOb3RlOiB0aGVyZSBpcyBkaXNjdXNzaW9uIGluIFsxXS4NCg0KWzFdIGh0dHBz
Oi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcHJvamVjdC9saW51eC1tZWRpYXRlay9wYXRjaC8yMDI0
MTEyMDEyNDQyMC4xMzM5MTQtNy1hbmdlbG9naW9hY2NoaW5vLmRlbHJlZ25vQGNvbGxhYm9yYS5j
b20vDQoNClJlZ2FyZHMsDQpDSw0KDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBBbmdlbG9HaW9hY2No
aW5vIERlbCBSZWdubyA8YW5nZWxvZ2lvYWNjaGluby5kZWxyZWdub0Bjb2xsYWJvcmEuY29tPg0K
PiAtLS0NCj4gIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHBpLmMgICAgICB8IDU1ICsr
KysrKysrKysrKysrKysrKysrKystLS0NCj4gIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtf
ZHBpX3JlZ3MuaCB8ICA2ICsrKw0KPiAgZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1f
ZHJ2LmMgIHwgIDIgKw0KPiAgMyBmaWxlcyBjaGFuZ2VkLCA1OCBpbnNlcnRpb25zKCspLCA1IGRl
bGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9t
dGtfZHBpLmMgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RwaS5jDQo+IGluZGV4IDc5
OTIzZDFiZmJjOS4uZjc2ZDFjNWI2OGJkIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0v
bWVkaWF0ZWsvbXRrX2RwaS5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtf
ZHBpLmMNCj4gQEAgLTE0NCw2ICsxNDQsNyBAQCBzdHJ1Y3QgbXRrX2RwaV9mYWN0b3Igew0KPiAg
ICogQGNzY19lbmFibGVfYml0OiBFbmFibGUgYml0IG9mIENTQy4NCj4gICAqIEBwaXhlbHNfcGVy
X2l0ZXI6IFF1YW50aXR5IG9mIHRyYW5zZmVycmVkIHBpeGVscyBwZXIgaXRlcmF0aW9uLg0KPiAg
ICogQGVkZ2VfY2ZnX2luX21tc3lzOiBJZiB0aGUgZWRnZSBjb25maWd1cmF0aW9uIGZvciBEUEkn
cyBvdXRwdXQgbmVlZHMgdG8gYmUgc2V0IGluIE1NU1lTLg0KPiArICogQGlzX2ludGVybmFsX2hk
bWk6IFNwZWNpZmllcyB3aGV0aGVyIHRoZSBEUEkgaXMgaW50ZXJuYWxseSBjb25uZWN0ZWQgdG8g
dGhlIEhETUkgYmxvY2sNCj4gICAqLw0KPiAgc3RydWN0IG10a19kcGlfY29uZiB7DQo+ICAgICAg
ICAgY29uc3Qgc3RydWN0IG10a19kcGlfZmFjdG9yICpkcGlfZmFjdG9yOw0KPiBAQCAtMTY0LDYg
KzE2NSw3IEBAIHN0cnVjdCBtdGtfZHBpX2NvbmYgew0KPiAgICAgICAgIHUzMiBjc2NfZW5hYmxl
X2JpdDsNCj4gICAgICAgICB1MzIgcGl4ZWxzX3Blcl9pdGVyOw0KPiAgICAgICAgIGJvb2wgZWRn
ZV9jZmdfaW5fbW1zeXM7DQo+ICsgICAgICAgYm9vbCBpc19pbnRlcm5hbF9oZG1pOw0KPiAgfTsN
Cj4gDQo+ICBzdGF0aWMgdm9pZCBtdGtfZHBpX21hc2soc3RydWN0IG10a19kcGkgKmRwaSwgdTMy
IG9mZnNldCwgdTMyIHZhbCwgdTMyIG1hc2spDQo+IEBAIC00OTIsNiArNDk0LDcgQEAgc3RhdGlj
IHZvaWQgbXRrX2RwaV9wb3dlcl9vZmYoc3RydWN0IG10a19kcGkgKmRwaSkNCj4gDQo+ICAgICAg
ICAgbXRrX2RwaV9kaXNhYmxlKGRwaSk7DQo+ICAgICAgICAgY2xrX2Rpc2FibGVfdW5wcmVwYXJl
KGRwaS0+cGl4ZWxfY2xrKTsNCj4gKyAgICAgICBjbGtfZGlzYWJsZV91bnByZXBhcmUoZHBpLT50
dmRfY2xrKTsNCj4gICAgICAgICBjbGtfZGlzYWJsZV91bnByZXBhcmUoZHBpLT5lbmdpbmVfY2xr
KTsNCj4gIH0NCj4gDQo+IEBAIC01MDgsNiArNTExLDEyIEBAIHN0YXRpYyBpbnQgbXRrX2RwaV9w
b3dlcl9vbihzdHJ1Y3QgbXRrX2RwaSAqZHBpKQ0KPiAgICAgICAgICAgICAgICAgZ290byBlcnJf
cmVmY291bnQ7DQo+ICAgICAgICAgfQ0KPiANCj4gKyAgICAgICByZXQgPSBjbGtfcHJlcGFyZV9l
bmFibGUoZHBpLT50dmRfY2xrKTsNCj4gKyAgICAgICBpZiAocmV0KSB7DQo+ICsgICAgICAgICAg
ICAgICBkZXZfZXJyKGRwaS0+ZGV2LCAiRmFpbGVkIHRvIGVuYWJsZSB0dmQgcGxsOiAlZFxuIiwg
cmV0KTsNCj4gKyAgICAgICAgICAgICAgIGdvdG8gZXJyX2VuZ2luZTsNCj4gKyAgICAgICB9DQo+
ICsNCj4gICAgICAgICByZXQgPSBjbGtfcHJlcGFyZV9lbmFibGUoZHBpLT5waXhlbF9jbGspOw0K
PiAgICAgICAgIGlmIChyZXQpIHsNCj4gICAgICAgICAgICAgICAgIGRldl9lcnIoZHBpLT5kZXYs
ICJGYWlsZWQgdG8gZW5hYmxlIHBpeGVsIGNsb2NrOiAlZFxuIiwgcmV0KTsNCj4gQEAgLTUxNyw2
ICs1MjYsOCBAQCBzdGF0aWMgaW50IG10a19kcGlfcG93ZXJfb24oc3RydWN0IG10a19kcGkgKmRw
aSkNCj4gICAgICAgICByZXR1cm4gMDsNCj4gDQo+ICBlcnJfcGl4ZWw6DQo+ICsgICAgICAgY2xr
X2Rpc2FibGVfdW5wcmVwYXJlKGRwaS0+dHZkX2Nsayk7DQo+ICtlcnJfZW5naW5lOg0KPiAgICAg
ICAgIGNsa19kaXNhYmxlX3VucHJlcGFyZShkcGktPmVuZ2luZV9jbGspOw0KPiAgZXJyX3JlZmNv
dW50Og0KPiAgICAgICAgIGRwaS0+cmVmY291bnQtLTsNCj4gQEAgLTU4NCw3ICs1OTUsOSBAQCBz
dGF0aWMgaW50IG10a19kcGlfc2V0X2Rpc3BsYXlfbW9kZShzdHJ1Y3QgbXRrX2RwaSAqZHBpLA0K
PiAgICAgICAgIHN0cnVjdCB2aWRlb21vZGUgdm0gPSB7IDAgfTsNCj4gDQo+ICAgICAgICAgZHJt
X2Rpc3BsYXlfbW9kZV90b192aWRlb21vZGUobW9kZSwgJnZtKTsNCj4gLSAgICAgICBtdGtfZHBp
X3NldF9waXhlbF9jbGsoZHBpLCAmdm0sIG1vZGUtPmNsb2NrKTsNCj4gKw0KPiArICAgICAgIGlm
ICghZHBpLT5jb25mLT5pc19pbnRlcm5hbF9oZG1pKQ0KPiArICAgICAgICAgICAgICAgbXRrX2Rw
aV9zZXRfcGl4ZWxfY2xrKGRwaSwgJnZtLCBtb2RlLT5jbG9jayk7DQo+IA0KPiAgICAgICAgIGRw
aV9wb2wuY2tfcG9sID0gTVRLX0RQSV9QT0xBUklUWV9GQUxMSU5HOw0KPiAgICAgICAgIGRwaV9w
b2wuZGVfcG9sID0gTVRLX0RQSV9QT0xBUklUWV9SSVNJTkc7DQo+IEBAIC02NDcsMTAgKzY2MCwx
OCBAQCBzdGF0aWMgaW50IG10a19kcGlfc2V0X2Rpc3BsYXlfbW9kZShzdHJ1Y3QgbXRrX2RwaSAq
ZHBpLA0KPiAgICAgICAgIGlmIChkcGktPmNvbmYtPnN1cHBvcnRfZGlyZWN0X3Bpbikgew0KPiAg
ICAgICAgICAgICAgICAgbXRrX2RwaV9jb25maWdfeWNfbWFwKGRwaSwgZHBpLT55Y19tYXApOw0K
PiAgICAgICAgICAgICAgICAgbXRrX2RwaV9jb25maWdfMm5faF9mcmUoZHBpKTsNCj4gLSAgICAg
ICAgICAgICAgIG10a19kcGlfZHVhbF9lZGdlKGRwaSk7DQo+ICsgICAgICAgICAgICAgICAvKiBE
UEkgY2FuIGNvbm5lY3QgdG8gZWl0aGVyIGFuIGV4dGVybmFsIGJyaWRnZSBvciB0aGUgaW50ZXJu
YWwgSERNSSBlbmNvZGVyICovDQo+ICsgICAgICAgICAgICAgICBpZiAoZHBpLT5jb25mLT5pc19p
bnRlcm5hbF9oZG1pKSB7DQo+ICsgICAgICAgICAgICAgICAgICAgICAgIG10a19kcGlfbWFzayhk
cGksIERQSV9DT04sIERQSV9PVVRQVVRfMVQxUF9FTiwgRFBJX09VVFBVVF8xVDFQX0VOKTsNCj4g
KyAgICAgICAgICAgICAgICAgICAgICAgbXRrX2RwaV9tYXNrKGRwaSwgRFBJX0NPTiwNCj4gKyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGRwaS0+Y29uZi0+aW5wdXRfMnBpeGVs
ID8gRFBJX0lOUFVUXzJQX0VOIDogMCwNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIERQSV9JTlBVVF8yUF9FTik7DQo+ICsgICAgICAgICAgICAgICB9IGVsc2Ugew0KPiAr
ICAgICAgICAgICAgICAgICAgICAgICBtdGtfZHBpX2R1YWxfZWRnZShkcGkpOw0KPiArICAgICAg
ICAgICAgICAgfQ0KPiAgICAgICAgICAgICAgICAgbXRrX2RwaV9jb25maWdfZGlzYWJsZV9lZGdl
KGRwaSk7DQo+ICAgICAgICAgfQ0KPiAtICAgICAgIGlmIChkcGktPmNvbmYtPmlucHV0XzJwaXhl
bCkgew0KPiArICAgICAgIGlmIChkcGktPmNvbmYtPmlucHV0XzJwaXhlbCAmJiAhZHBpLT5jb25m
LT5pc19pbnRlcm5hbF9oZG1pKSB7DQo+ICAgICAgICAgICAgICAgICBtdGtfZHBpX21hc2soZHBp
LCBEUElfQ09OLCBEUElOVEZfSU5QVVRfMlBfRU4sDQo+ICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgRFBJTlRGX0lOUFVUXzJQX0VOKTsNCj4gICAgICAgICB9DQo+IEBAIC05MTksMTQgKzk0
MCwxNiBAQCB2b2lkIG10a19kcGlfc3RhcnQoc3RydWN0IGRldmljZSAqZGV2KQ0KPiAgew0KPiAg
ICAgICAgIHN0cnVjdCBtdGtfZHBpICpkcGkgPSBkZXZfZ2V0X2RydmRhdGEoZGV2KTsNCj4gDQo+
IC0gICAgICAgbXRrX2RwaV9wb3dlcl9vbihkcGkpOw0KPiArICAgICAgIGlmICghZHBpLT5jb25m
LT5pc19pbnRlcm5hbF9oZG1pKQ0KPiArICAgICAgICAgICAgICAgbXRrX2RwaV9wb3dlcl9vbihk
cGkpOw0KPiAgfQ0KPiANCj4gIHZvaWQgbXRrX2RwaV9zdG9wKHN0cnVjdCBkZXZpY2UgKmRldikN
Cj4gIHsNCj4gICAgICAgICBzdHJ1Y3QgbXRrX2RwaSAqZHBpID0gZGV2X2dldF9kcnZkYXRhKGRl
dik7DQo+IA0KPiAtICAgICAgIG10a19kcGlfcG93ZXJfb2ZmKGRwaSk7DQo+ICsgICAgICAgaWYg
KCFkcGktPmNvbmYtPmlzX2ludGVybmFsX2hkbWkpDQo+ICsgICAgICAgICAgICAgICBtdGtfZHBp
X3Bvd2VyX29mZihkcGkpOw0KPiAgfQ0KPiANCj4gIHVuc2lnbmVkIGludCBtdGtfZHBpX2VuY29k
ZXJfaW5kZXgoc3RydWN0IGRldmljZSAqZGV2KQ0KPiBAQCAtMTAyMSw2ICsxMDQ0LDggQEAgc3Rh
dGljIGNvbnN0IHN0cnVjdCBtdGtfZHBpX2ZhY3RvciBkcGlfZmFjdG9yX210ODE5NV9kcF9pbnRm
W10gPSB7DQo+ICAgICAgICAgeyA3MDAwMCAtIDEsIDQgfSwgeyAyMDAwMDAgLSAxLCAyIH0sIHsg
VTMyX01BWCwgMSB9DQo+ICB9Ow0KPiANCj4gK3N0YXRpYyBjb25zdCBzdHJ1Y3QgbXRrX2RwaV9m
YWN0b3IgZHBpX2ZhY3Rvcl9tdDgxOTVfZHBpID0geyBVMzJfTUFYLCAxIH07DQo+ICsNCj4gIHN0
YXRpYyBjb25zdCBzdHJ1Y3QgbXRrX2RwaV9jb25mIG10ODE3M19jb25mID0gew0KPiAgICAgICAg
IC5kcGlfZmFjdG9yID0gZHBpX2ZhY3Rvcl9tdDgxNzMsDQo+ICAgICAgICAgLm51bV9kcGlfZmFj
dG9yID0gQVJSQVlfU0laRShkcGlfZmFjdG9yX210ODE3MyksDQo+IEBAIC0xMTEzLDYgKzExMzgs
MjUgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBtdGtfZHBpX2NvbmYgbXQ4MTkyX2NvbmYgPSB7DQo+
ICAgICAgICAgLmNzY19lbmFibGVfYml0ID0gQ1NDX0VOQUJMRSwNCj4gIH07DQo+IA0KPiArc3Rh
dGljIGNvbnN0IHN0cnVjdCBtdGtfZHBpX2NvbmYgbXQ4MTk1X2NvbmYgPSB7DQo+ICsgICAgICAg
LmRwaV9mYWN0b3IgPSAmZHBpX2ZhY3Rvcl9tdDgxOTVfZHBpLA0KPiArICAgICAgIC5udW1fZHBp
X2ZhY3RvciA9IDEsDQo+ICsgICAgICAgLm1heF9jbG9ja19raHogPSA1OTQwMDAsDQo+ICsgICAg
ICAgLm91dHB1dF9mbXRzID0gbXQ4MTgzX291dHB1dF9mbXRzLA0KPiArICAgICAgIC5udW1fb3V0
cHV0X2ZtdHMgPSBBUlJBWV9TSVpFKG10ODE4M19vdXRwdXRfZm10cyksDQo+ICsgICAgICAgLnBp
eGVsc19wZXJfaXRlciA9IDEsDQo+ICsgICAgICAgLmlzX2NrX2RlX3BvbCA9IHRydWUsDQo+ICsg
ICAgICAgLnN3YXBfaW5wdXRfc3VwcG9ydCA9IHRydWUsDQo+ICsgICAgICAgLnN1cHBvcnRfZGly
ZWN0X3BpbiA9IHRydWUsDQo+ICsgICAgICAgLmRpbWVuc2lvbl9tYXNrID0gSFBXX01BU0ssDQo+
ICsgICAgICAgLmh2c2l6ZV9tYXNrID0gSFNJWkVfTUFTSywNCj4gKyAgICAgICAuY2hhbm5lbF9z
d2FwX3NoaWZ0ID0gQ0hfU1dBUCwNCj4gKyAgICAgICAueXV2NDIyX2VuX2JpdCA9IFlVVjQyMl9F
TiwNCj4gKyAgICAgICAuY3NjX2VuYWJsZV9iaXQgPSBDU0NfRU5BQkxFLA0KPiArICAgICAgIC5p
c19pbnRlcm5hbF9oZG1pID0gdHJ1ZSwNCj4gKyAgICAgICAuaW5wdXRfMnBpeGVsID0gdHJ1ZSwN
Cj4gK307DQo+ICsNCj4gIHN0YXRpYyBjb25zdCBzdHJ1Y3QgbXRrX2RwaV9jb25mIG10ODE5NV9k
cGludGZfY29uZiA9IHsNCj4gICAgICAgICAuZHBpX2ZhY3RvciA9IGRwaV9mYWN0b3JfbXQ4MTk1
X2RwX2ludGYsDQo+ICAgICAgICAgLm51bV9kcGlfZmFjdG9yID0gQVJSQVlfU0laRShkcGlfZmFj
dG9yX210ODE5NV9kcF9pbnRmKSwNCj4gQEAgLTEyMTYsNiArMTI2MCw3IEBAIHN0YXRpYyBjb25z
dCBzdHJ1Y3Qgb2ZfZGV2aWNlX2lkIG10a19kcGlfb2ZfaWRzW10gPSB7DQo+ICAgICAgICAgeyAu
Y29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDgxODgtZHAtaW50ZiIsIC5kYXRhID0gJm10ODE5NV9k
cGludGZfY29uZiB9LA0KPiAgICAgICAgIHsgLmNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ4MTky
LWRwaSIsIC5kYXRhID0gJm10ODE5Ml9jb25mIH0sDQo+ICAgICAgICAgeyAuY29tcGF0aWJsZSA9
ICJtZWRpYXRlayxtdDgxOTUtZHAtaW50ZiIsIC5kYXRhID0gJm10ODE5NV9kcGludGZfY29uZiB9
LA0KPiArICAgICAgIHsgLmNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ4MTk1LWRwaSIsIC5kYXRh
ID0gJm10ODE5NV9jb25mIH0sDQo+ICAgICAgICAgeyAvKiBzZW50aW5lbCAqLyB9LA0KPiAgfTsN
Cj4gIE1PRFVMRV9ERVZJQ0VfVEFCTEUob2YsIG10a19kcGlfb2ZfaWRzKTsNCj4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHBpX3JlZ3MuaCBiL2RyaXZlcnMvZ3B1
L2RybS9tZWRpYXRlay9tdGtfZHBpX3JlZ3MuaA0KPiBpbmRleCBhMGIxZDE4YmJiZjcuLjNjMjRk
OWU5ZjI0MSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcGlf
cmVncy5oDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHBpX3JlZ3MuaA0K
PiBAQCAtNDAsNiArNDAsMTIgQEANCj4gICNkZWZpbmUgRkFLRV9ERV9MRVZFTiAgICAgICAgICAg
ICAgICAgIEJJVCgyMSkNCj4gICNkZWZpbmUgRkFLRV9ERV9ST0REICAgICAgICAgICAgICAgICAg
IEJJVCgyMikNCj4gICNkZWZpbmUgRkFLRV9ERV9SRVZFTiAgICAgICAgICAgICAgICAgIEJJVCgy
MykNCj4gKw0KPiArLyogRFBJX0NPTjogRFBJIGluc3RhbmNlcyAqLw0KPiArI2RlZmluZSBEUElf
T1VUUFVUXzFUMVBfRU4gICAgICAgICAgICAgQklUKDI0KQ0KPiArI2RlZmluZSBEUElfSU5QVVRf
MlBfRU4gICAgICAgICAgICAgICAgICAgICAgICBCSVQoMjUpDQo+ICsNCj4gKy8qIERQSV9DT046
IERQSU5URiBpbnN0YW5jZXMgKi8NCj4gICNkZWZpbmUgRFBJTlRGX1lVVjQyMl9FTiAgICAgICAg
ICAgICAgIEJJVCgyNCkNCj4gICNkZWZpbmUgRFBJTlRGX0NTQ19FTkFCTEUgICAgICAgICAgICAg
IEJJVCgyNikNCj4gICNkZWZpbmUgRFBJTlRGX0lOUFVUXzJQX0VOICAgICAgICAgICAgIEJJVCgy
OSkNCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2Rydi5j
IGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fZHJ2LmMNCj4gaW5kZXggOWE4ZWY4
NTU4ZGE5Li5iYTQ1MzkxNTBmNTIgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9tZWRp
YXRlay9tdGtfZHJtX2Rydi5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtf
ZHJtX2Rydi5jDQo+IEBAIC04MDcsNiArODA3LDggQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBvZl9k
ZXZpY2VfaWQgbXRrX2RkcF9jb21wX2R0X2lkc1tdID0gew0KPiAgICAgICAgICAgLmRhdGEgPSAo
dm9pZCAqKU1US19EUEkgfSwNCj4gICAgICAgICB7IC5jb21wYXRpYmxlID0gIm1lZGlhdGVrLG10
ODE5NS1kcC1pbnRmIiwNCj4gICAgICAgICAgIC5kYXRhID0gKHZvaWQgKilNVEtfRFBfSU5URiB9
LA0KPiArICAgICAgIHsgLmNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ4MTk1LWRwaSIsDQo+ICsg
ICAgICAgICAuZGF0YSA9ICh2b2lkICopTVRLX0RQSSB9LA0KPiAgICAgICAgIHsgLmNvbXBhdGli
bGUgPSAibWVkaWF0ZWssbXQyNzAxLWRzaSIsDQo+ICAgICAgICAgICAuZGF0YSA9ICh2b2lkICop
TVRLX0RTSSB9LA0KPiAgICAgICAgIHsgLmNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ4MTczLWRz
aSIsDQo+IC0tDQo+IDIuNDcuMA0KPiANCg0K

