Return-Path: <linux-kernel+bounces-209585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 37C76903805
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 11:40:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B86F51F248D9
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 09:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB135176AD4;
	Tue, 11 Jun 2024 09:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="rWdV2bj/";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="Hb7nRvSS"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24E8E2230F
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 09:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718098839; cv=fail; b=M7lZnwHIyWUGunwWj/ghJS7fXsKRznHlpIMPUyLi/lRJkl0U9U+VCBRn6wXZFB0KWBkzTd4Jovfj9vF3XihuLAKGTx4tYysvzxUVc7pMdG684VQqa1ebWrhvfzzCmA8/+k/DcDEYLLWZ0f5R/US9yTOq5R4Cxn10ldC0eRxHqm0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718098839; c=relaxed/simple;
	bh=G/zZY20CCigJFpcmil2zua4vkR+IKrafK5fD/ISVV08=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GpUyeDeQaUBERfIaiYH59DhOHEhDXiBXw1/AhKadyrCYvk1aD87aKWCmc7aM1XN+/6jYggVIZR7dOuWKwRXHqX6VgHtF1mCsNpnmN3coNZ6Nyent+pdAXiUIAQ6b0I4ZYH3Q4BpQOI36yL5GKyUN06//Uui6wXz60BQsH4shSHw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=rWdV2bj/; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=Hb7nRvSS; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: a5bda97227d611efa54bbfbb386b949c-20240611
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=G/zZY20CCigJFpcmil2zua4vkR+IKrafK5fD/ISVV08=;
	b=rWdV2bj/yGDw4U4kulbbEQWHaGmOAzHDsu07QWPAz9HCnTFThvqHINhDG9BQEQ0sjJ2xCG5pY29zRtXhE05WJo8m3bwfrEATsaFljXEXRT1ONZDTOxioXC7OxEesXfDBzrUw0Z0mExSvwLGpsueeFaHgfbPAOdmcwEdJfXn3ORU=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.39,REQID:4c2f2fab-0de6-4ff0-a537-273fc16320dd,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:393d96e,CLOUDID:52bb7044-4544-4d06-b2b2-d7e12813c598,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: a5bda97227d611efa54bbfbb386b949c-20240611
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 435051857; Tue, 11 Jun 2024 17:40:32 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 11 Jun 2024 17:40:31 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 11 Jun 2024 17:40:31 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kmzH32kWc442VvVtpwiiM4egRlw5v6Yqe5fAPJVi86hAJW5Qfh0hNo3TgzzFV/NOYh0hDlztGjolvcfnnyxFMVx46uQkEF9Xk9T4ThlXMtVISxLHCaBWWIOzk1fv3UddlkYRis73RJabqwjsDDbRKpyN22fwZwqXf43PHtQirSaITL/dqzj1xLhfCqP4PfugzBWipTCKhj70ITgqBV48C+HmHdNMKDJGgG7hTiaGFyY5cErDCUrtldM28VyLf+FqYZEytrV4vUgG5UfYhpkIdOlGDj/G315VWv89bUBlk04lgc0w5U9eifZwA6X88ouJ7ohilElN46/FoEhI1vMFdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G/zZY20CCigJFpcmil2zua4vkR+IKrafK5fD/ISVV08=;
 b=DjNTS4XAnymliNzz207Ea0R3Z645Fbs4Vschj9xt7kVKWxgSFZJAkD2SHgIm2Qt/+zrulJOsOyd0w/jg/6LD2As8HFKeGQK6K+qv7zum36/iKU5Ilc3wBrYRDp8Iu4CPexSf9n9fzZ3onzRm7JpanRoZTW492ukWHTL5rcow4ldvb7TuKUDGgU1WksZwi7W5T2NDbixWyUQoG4Cs1pdxLuWCJrCZfv6nBV0JzW1T/ctPHPuY7yVsm19zZs2j2FDUm19Sy+pvPnddiS9OlDVIcAP1bkKXxKjoW4pg8NpLergJUZep8yjjMnX2iPSXYEAD91EDd0QjssRYzLA0FecTSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G/zZY20CCigJFpcmil2zua4vkR+IKrafK5fD/ISVV08=;
 b=Hb7nRvSSHADGz2OdszQGUalP0eV/DuaejB6C3+Mu+Ah1ImaUM5FOx1OQpRJ61H0uVYZQ83LqA7i3seTcTC2+XvObM0TsDE45qMdvSOEnq6CovCd90+sOV52y6UMGhfK181nQH/E1K009TIub8upDARximswedziIA/fQ46fz6y0=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by TYZPR03MB6471.apcprd03.prod.outlook.com (2603:1096:400:1c9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.17; Tue, 11 Jun
 2024 09:39:24 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54%6]) with mapi id 15.20.7677.014; Tue, 11 Jun 2024
 09:39:24 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: =?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= <Shawn.Sung@mediatek.com>,
	"chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>
CC: "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	=?utf-8?B?QmliYnkgSHNpZWggKOisnea/n+mBoCk=?= <Bibby.Hsieh@mediatek.com>,
	"jason-ch.chen@mediatek.corp-partner.google.com"
	<jason-ch.chen@mediatek.corp-partner.google.com>,
	=?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
	"daniel@ffwll.ch" <daniel@ffwll.ch>, "p.zabel@pengutronix.de"
	<p.zabel@pengutronix.de>, "dri-devel@lists.freedesktop.org"
	<dri-devel@lists.freedesktop.org>, "airlied@gmail.com" <airlied@gmail.com>,
	"sean@poorly.run" <sean@poorly.run>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "fshao@chromium.org" <fshao@chromium.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v8 11/16] drm/mediatek: Support "Pre-multiplied" blending
 in OVL
Thread-Topic: [PATCH v8 11/16] drm/mediatek: Support "Pre-multiplied" blending
 in OVL
Thread-Index: AQHat/PF4atSFGFZx0GsCBYRfQE5MLHCVpSA
Date: Tue, 11 Jun 2024 09:39:24 +0000
Message-ID: <d1888aad8eca5183c9413dc8493fa3438d800ef0.camel@mediatek.com>
References: <20240606092635.27981-1-shawn.sung@mediatek.com>
	 <20240606092635.27981-12-shawn.sung@mediatek.com>
In-Reply-To: <20240606092635.27981-12-shawn.sung@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|TYZPR03MB6471:EE_
x-ms-office365-filtering-correlation-id: 8f6954d5-23f2-4c83-15b0-08dc89fa6156
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|7416005|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?MUxBenJuRzJmWUdBRFhpM096QXVwQVBzOFRadEpNaFB2ZEFVWlN4MEhkNThs?=
 =?utf-8?B?MkxOUkJ1TGkzYkRxYzZrWlpRcmpDM2Q1blRjOGhNU3BWTjhHZGdmQW1DbHZa?=
 =?utf-8?B?QWJKVWFqcUhPTU5McjRmRXJYby9YVzRtcDZ1VGJpNlR1K0t1SDFldER3aElD?=
 =?utf-8?B?YlVHNGFJWWhIdVNLWDVvUVhXU25iNEprN0J5UVcxbzV1WDJnYlB1eXo5Y1NO?=
 =?utf-8?B?alA5L01SeXB5ZUZpS0orWWVlWUZpU09JQ0RPVHZ0eFRmY0xlNjZzdC9kVHRZ?=
 =?utf-8?B?ai9yR3Z6aXUzWEhiRVJIbENLaXU0REswV3h2a3VIQkxrZU1ja0xEcW9EQ2hD?=
 =?utf-8?B?ZVNvemNPNzhTV1BHT1RXVUhvd1NmRUVTNlN6elBxRU9GNDZINkdmMWdhK3lX?=
 =?utf-8?B?eVRXK3k3ZmJ3TVR3dENocEkzRWxHQS8zT3IyeFFzS1JZUHFKNSs5dkQycTJH?=
 =?utf-8?B?enU0cjliTVZqZnFad2Nwa2kzTmV4REZHNHY2YlFBOFBMdE9zbnVuc3BnRkdD?=
 =?utf-8?B?RFZidnNsRzVKaDJsTDFYQklZR3d3SnRZa01RTDhUblgzeVYvdzRRV2tpNkM5?=
 =?utf-8?B?R2xLeXQxZk1ITVdOSlVVaTE3YzQ5clh1YlRNVDBpNG8xbEhNVzUyYjRIL0Fi?=
 =?utf-8?B?dlhYbzh6WG8vV093YzV5cUJyUjZTRm9BaDY1eWNWWVpDek1sa21zTGIrb21n?=
 =?utf-8?B?VGNSZExYYmF5VitDMDZqTTZHd3VOVmw2OVJSVzU1VElzSXZjcEo0YmZ4Sm1z?=
 =?utf-8?B?ck1Yc1VJY1FYY0t1RkNwYnV0QklCYnd5SlN3dWJ6amhPUW53ZjRDSlgwMzhN?=
 =?utf-8?B?R2t1bkNIaXROcWtjMTZZUkRQQndqYjNNZm9NN2szN0VsTm1WM2JITEY3WDJC?=
 =?utf-8?B?a08xcmU1UUVwVlk0dzQxSzZVUFptejhGYThUalYrcEQrV3hmQzdLS0tIaUNt?=
 =?utf-8?B?NHcybWc0RXJWWm5kWXBrN2lXNlJmdWFtbmozOWVUZW9RelhZQUpwdjhTbkhk?=
 =?utf-8?B?ZEo4YStOdy9kOG5UT3RiSnJ4MDcrUzdwSTVZMWNxTVJramMxSHd5YkE1eDgw?=
 =?utf-8?B?anhxZTFDM1NyRWpnQ3loY0dCQlJaVWxUZ01WdEMwV2s2UUhEcFRpeFNXMGFJ?=
 =?utf-8?B?ZzhUOE1UUExCQjdTa3N1a0hnZCtINkRBL1JmQjROdVhmRXJOTU8vWEdHOG1D?=
 =?utf-8?B?OTQ2V3M3Q1VEQVVXbndldHdkN1VpK0ovb2RBZGlvdDdoYUVJemxzVUpUN0d6?=
 =?utf-8?B?d0MxZWhRY3duYUIxYklJaXR1dE9NQ3IrZDErWUl5dnV6elRSbTFrVFg1SXdX?=
 =?utf-8?B?RDR2TUZ5YS96VGQ2SzM0cjFBbzRuYWJPb2xhTmJQUkVLRzk3S1FFNzh4SnJq?=
 =?utf-8?B?TTgwbzhmOVFSK2V1OGloS0lzVm4xd0RBOVlZcW0zWWZBWEVGaytTUFYrNDdY?=
 =?utf-8?B?VDRTdHZmdExReGdIbERVcG5ydFk4U2tlWTNTY2RxUFVveHlXdXZ4UkZEZjdK?=
 =?utf-8?B?VFFDWjNSYTJYMVBUMXhjcThSU0hXTUJrOVNQcjk2QlZHbzN4NHNPS2lGQytK?=
 =?utf-8?B?ZHdwZWpQN24zRHp4ZTZqNXJ5TUtoTk5LSzZUWUJZRG92Rm5STkFodzU2RU81?=
 =?utf-8?B?d3FjYXhHalloQkxFRlJoclVYSi9HaXVwZks4enpGQVpRVXdPSXlPRTFaTW44?=
 =?utf-8?B?WlNLMzNhZGxpd2hwaUFZWUJZVC9mWDdLdWVtRFdTTGU0K2E0Qm5GOW9OWkFN?=
 =?utf-8?B?Zlo4eWQzdW9NSlN4TVVkdUtqU2sxR1Nkb00ya1QxdWxCYmhhT3I0MWlGZm1Q?=
 =?utf-8?Q?qlkOnCpxoBo9Uwr3uDxNJuHVwy0kTULc85GCQ=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z0FjNTVjQUhtSkNEMEV2Vitsei9UL3lxWTh1QWx4ZklRclZ4a1ZaN3ExZ1hm?=
 =?utf-8?B?Ynh6NkgrT0tMN1ZDOTFiWjYyemNvanQwSm9iSVQ3ZGFhKzZtV3R6L0FnV2Nx?=
 =?utf-8?B?ZktQYzlyb3NPdEljWmNrVU1uT0syT25GZkU0WFJrM2FQMEVFSGVQSWJoNzVH?=
 =?utf-8?B?anpscXBLdzVmSTltM3psektXWFN0cWJoeG9pb0VXdWlFOGNadzJacjUxdHQ5?=
 =?utf-8?B?RWhlL3BLakdUN2hEVFZJZm1zdnNXQ1JvenBNa2JNUXI3RlpFSFRpTVpzUERu?=
 =?utf-8?B?SFB6TXNRSTBxbnNGTHg0NHp2U0JjKzRHa0wySzdyR2t1NXFQa1VOOWd4RXZz?=
 =?utf-8?B?VWxTR3NQd3JldjNCSmxuaDFYNG5UcXRuT3Q2bW1EMUVZUXB2dUw1M2RUdnpy?=
 =?utf-8?B?N3dGRVNrcEVKSTdQNkdoL1ZidXZHSzY2dFB3di9PeTBrd1JkeUFFeEUxWUFU?=
 =?utf-8?B?RG1EbEhWUTJpY1VPOFh3Tm1Od2RaeTMvNzF5cUI1UkovRWd0cUNsaWR1Y2Zx?=
 =?utf-8?B?M2MyclVXNlh6eDVWNzM4blNEeGR4OHh4TWpiRXFnR0FDK0FaMCswSUZaSk0r?=
 =?utf-8?B?aEhWSkFjcFdMc3pMUUtCNmh3VjMyeEwwKzhvb2tqZHYwV0ExLzZaT3pIZTUz?=
 =?utf-8?B?L0pZUzU1NjN6elpWM1JhTi9oRnEwcjZmbzE5dkwrWGluSXRnd09aZ0hIbVZS?=
 =?utf-8?B?RVZSb2tTR1lXcWJpRDlaR1h5ZEZGYkNlY0dMdEVqcm1Md2d6Z2hQV2FKYUM0?=
 =?utf-8?B?ODVJWGVuSFBZSjA2Y0RoaXhpdllaaHE5RDhBUnJIT2dFRzNxMTk1Y2hOSk4x?=
 =?utf-8?B?NzRmR0tIeStPNncyY3Q5Y2pGOGR6NlFZNWF1UGNSNkZaSFI3Vm0xd2VBYkFS?=
 =?utf-8?B?WXRISEh6VnJDVjV2bTgrd2t2YjVzNllBWTlSa3M1ckU3TlM4VFNMNFdsM1hv?=
 =?utf-8?B?cC9BM1hxWDBaZU1na001MSt1UmJyWHBMSlN6NSt0QjVodXVYdUNkdHVsNDl6?=
 =?utf-8?B?UUNvTjZacktlajAzN3dhMWorWXBnblJ3UW1TU20xOXhBL3A2Q0xvWnJ1SXdn?=
 =?utf-8?B?SzBja2ZvdHg0NmxqdHVHRkhaQ0lVMy8xcHVHQmc2a0xLL2ZzODU3TWZ2d1hy?=
 =?utf-8?B?ak5XeUdHVXhNRjZrbnpvN09DOWc1MzN2NFlYSk1TWmwyMGwyYUdyMHdZODVk?=
 =?utf-8?B?Q2lJM3Q2QkFBM0VYbzM3RnlMY1luL29ad1J5ZGdNRE5pbEtjQTcvUDhLZjlC?=
 =?utf-8?B?WXBMeDdKREc4TnFTcVFJUGlYUW5jQzJFWmFvWU5ReW05Zm1QL3RJaU9xR213?=
 =?utf-8?B?VklWMVRpc2d0eExMaHBjVE9WbHBDQVhiZXpkU2lEWmRiR3d1QjlUQWpuS0lq?=
 =?utf-8?B?TjdoUnJXZzlVd1hmcWFsNmJHNXBYWkw4WmpLclhEQ2dtaS84MEN3VC9EcnZv?=
 =?utf-8?B?YmpwdzRFZ0ZxYi8xY2t6WXg3V3ZidTY5bmw0ZVNSVlgrUTRDMUljbm9DMFhT?=
 =?utf-8?B?T3R3M053eDZudkFiUkJkM0UwalhhNWQ1VmRROCtoUmtMQUdQT1h2OURpUjAv?=
 =?utf-8?B?d1hOdEtwcjBkOEd0RTgySGlWTGlNQWRISkhlV1l6Mk1pbUtuSXFGbG5EeFJS?=
 =?utf-8?B?cGg2VVE5bXhvYklzNHVuSzROWjMxR2NhRHkvR3ZBMWo3WHR3bkxSSGpMVWJC?=
 =?utf-8?B?UEVNWG1SWUJqQzR4RWtrczFiYW9qWm5zc1c2Q2c4ajFFVU5LMjhUUFQrTnU0?=
 =?utf-8?B?QjBsTXNFR1lWbWNJNjVFcmZEQjY1cTJtNU1KWWNRcHJXekRNSm5uVlhHRVVy?=
 =?utf-8?B?K2lTZS8zM1NiZEU5bXZhVnFqcktOM2R0OEtyU1ZZbEJRdVJrTnUyZ0pMNGJS?=
 =?utf-8?B?NU1pSERhL0dMaE1TNWl4a2VmdithekFzZ21wUVBxVXNJejlTWlVSZjBDamk5?=
 =?utf-8?B?ZFFna29iV2FYSjhKbVVKUmd1cWFhZjNlci9DYS9oWXI1TTd3U0tLallOOUhY?=
 =?utf-8?B?YURlYVFYR0xzMStHMUNrWWJTaXMxR1lyN2ZtczhFL0tzc3VsTEM1RVFMWHV0?=
 =?utf-8?B?TERuN1hFNlNIVzNnRGFTTmFHUytNdXFsQ3U3ZjduOENrV1ZSZmRHUDFMMHRE?=
 =?utf-8?Q?1vwQocPK9DnT+FUqLYgx+gf5h?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <ECF85170682F294BA7FA6B2330B1DEA7@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f6954d5-23f2-4c83-15b0-08dc89fa6156
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2024 09:39:24.7075
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tYAHcc1AVTcK18XSw5JfrrSxRQ0m4ck6TS2odXXmC4nh5h9Tks1gdgoJP1aTDdTHZwdJYeuyz/fj1avzGHE3Aw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB6471

SGksIFNoYXduOg0KDQpPbiBUaHUsIDIwMjQtMDYtMDYgYXQgMTc6MjYgKzA4MDAsIFNoYXduIFN1
bmcgd3JvdGU6DQo+IEZyb206IEhzaWFvIENoaWVuIFN1bmcgPHNoYXduLnN1bmdAbWVkaWF0ZWsu
Y29tPg0KPiANCj4gU3VwcG9ydCAiUHJlLW11bHRpcGxpZWQiIGFscGhhIGJsZW5kaW5nIG1vZGUg
b24gaW4gT1ZMLg0KPiBCZWZvcmUgdGhpcyBwYXRjaCwgb25seSB0aGUgImNvdmVyYWdlIiBtb2Rl
IGlzIHN1cHBvcnRlZC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEhzaWFvIENoaWVuIFN1bmcgPHNo
YXduLnN1bmdAbWVkaWF0ZWsuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRl
ay9tdGtfZGlzcF9vdmwuYyB8IDQwICsrKysrKysrKysrKysrKysrKysrKy0tLS0NCj4gIDEgZmls
ZSBjaGFuZ2VkLCAzNCBpbnNlcnRpb25zKCspLCA2IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9vdmwuYyBiL2RyaXZlcnMv
Z3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9vdmwuYw0KPiBpbmRleCA1NGE2ZjExYWE4NjcuLmRl
MTYzMzk4ODkyMSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19k
aXNwX292bC5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9vdmwu
Yw0KPiBAQCAtNTIsMTMgKzUyLDE2IEBADQo+ICAjZGVmaW5lIEdNQ19USFJFU0hPTERfSElHSAko
KDEgPDwgR01DX1RIUkVTSE9MRF9CSVRTKSAvIDQpDQo+ICAjZGVmaW5lIEdNQ19USFJFU0hPTERf
TE9XCSgoMSA8PCBHTUNfVEhSRVNIT0xEX0JJVFMpIC8gOCkNCj4gIA0KPiArI2RlZmluZSBPVkxf
Q09OX0NMUkZNVF9NQU4JQklUKDIzKQ0KPiAgI2RlZmluZSBPVkxfQ09OX0JZVEVfU1dBUAlCSVQo
MjQpDQo+IC0jZGVmaW5lIE9WTF9DT05fTVRYX1lVVl9UT19SR0IJKDYgPDwgMTYpDQo+ICsjZGVm
aW5lIE9WTF9DT05fUkdCX1NXQVAJQklUKDI1KQ0KPiAgI2RlZmluZSBPVkxfQ09OX0NMUkZNVF9S
R0IJKDEgPDwgMTIpDQo+ICAjZGVmaW5lIE9WTF9DT05fQ0xSRk1UX1JHQkE4ODg4CSgyIDw8IDEy
KQ0KPiAgI2RlZmluZSBPVkxfQ09OX0NMUkZNVF9BUkdCODg4OAkoMyA8PCAxMikNCj4gICNkZWZp
bmUgT1ZMX0NPTl9DTFJGTVRfVVlWWQkoNCA8PCAxMikNCj4gICNkZWZpbmUgT1ZMX0NPTl9DTFJG
TVRfWVVZVgkoNSA8PCAxMikNCj4gKyNkZWZpbmUgT1ZMX0NPTl9NVFhfWVVWX1RPX1JHQgkoNiA8
PCAxNikNCj4gKyNkZWZpbmUgT1ZMX0NPTl9DTFJGTVRfUEFSR0I4ODg4CShPVkxfQ09OX0NMUkZN
VF9BUkdCODg4OCB8IE9WTF9DT05fQ0xSRk1UX01BTikNCj4gICNkZWZpbmUgT1ZMX0NPTl9DTFJG
TVRfUkdCNTY1KG92bCkJKChvdmwpLT5kYXRhLT5mbXRfcmdiNTY1X2lzXzAgPyBcDQo+ICAJCQkJ
CTAgOiBPVkxfQ09OX0NMUkZNVF9SR0IpDQo+ICAjZGVmaW5lIE9WTF9DT05fQ0xSRk1UX1JHQjg4
OChvdmwpCSgob3ZsKS0+ZGF0YS0+Zm10X3JnYjU2NV9pc18wID8gXA0KPiBAQCAtNzIsNiArNzUs
OCBAQA0KPiAgI2RlZmluZQlPVkxfQ09OX1ZJUlRfRkxJUAlCSVQoOSkNCj4gICNkZWZpbmUJT1ZM
X0NPTl9IT1JaX0ZMSVAJQklUKDEwKQ0KPiAgDQo+ICsjZGVmaW5lIE9WTF9DT0xPUl9BTFBIQQkJ
R0VOTUFTSygzMSwgMjQpDQo+ICsNCj4gIHN0YXRpYyBpbmxpbmUgYm9vbCBpc18xMGJpdF9yZ2Io
dTMyIGZtdCkNCj4gIHsNCj4gIAlzd2l0Y2ggKGZtdCkgew0KPiBAQCAtMjk2LDcgKzMwMSwxMyBA
QCB2b2lkIG10a19vdmxfY29uZmlnKHN0cnVjdCBkZXZpY2UgKmRldiwgdW5zaWduZWQgaW50IHcs
DQo+ICAJaWYgKHcgIT0gMCAmJiBoICE9IDApDQo+ICAJCW10a19kZHBfd3JpdGVfcmVsYXhlZChj
bWRxX3BrdCwgaCA8PCAxNiB8IHcsICZvdmwtPmNtZHFfcmVnLCBvdmwtPnJlZ3MsDQo+ICAJCQkJ
ICAgICAgRElTUF9SRUdfT1ZMX1JPSV9TSVpFKTsNCj4gLQltdGtfZGRwX3dyaXRlX3JlbGF4ZWQo
Y21kcV9wa3QsIDB4MCwgJm92bC0+Y21kcV9yZWcsIG92bC0+cmVncywgRElTUF9SRUdfT1ZMX1JP
SV9CR0NMUik7DQo+ICsNCj4gKwkvKg0KPiArCSAqIFRoZSBiYWNrZ3JvdW5kIGNvbG9yIG11c3Qg
YmUgb3BhcXVlIGJsYWNrIChBUkdCKSwNCj4gKwkgKiBvdGhlcndpc2UgdGhlIGFscGhhIGJsZW5k
aW5nIHdpbGwgaGF2ZSBubyBlZmZlY3QNCj4gKwkgKi8NCj4gKwltdGtfZGRwX3dyaXRlX3JlbGF4
ZWQoY21kcV9wa3QsIE9WTF9DT0xPUl9BTFBIQSwgJm92bC0+Y21kcV9yZWcsDQo+ICsJCQkgICAg
ICBvdmwtPnJlZ3MsIERJU1BfUkVHX09WTF9ST0lfQkdDTFIpOw0KDQpUaGUgY292ZXJhZ2UgbW9k
ZSBmb3JtdWxhIGlzOg0KZHN0LlJHQiA9IHNyYy5SR0IgKiBzcmMuQSArIGRzdC5SR0IgKiAoMSAt
IHNyYy5BKQ0KDQpUaGUgcHJlLW11bHRpcGxpZWQgbW9kZSBmb3JtdWxhIGlzOg0KZHN0LlJHQiA9
IHNyYy5SR0IgKyBkc3QuUkdCICogKDEgLSBzcmMuQSkNCg0KQm90aCBmb3JtdWxhIGhhcyBubyBk
ZXN0aW5hdGlvbiBhbHBoYSAoSSB0aGluayBiYWNrZ3JvdW5kIGNvbG9yIGlzIGxhc3QgZGVzdGlu
YXRpb24pLA0Kd2h5IGNvdmVyYWdlIG1vZGUgd29yayBmaW5lIGJ1dCBwcmUtbXVsdGlwbGllZCBt
b2RlIGhhcyBzb21ldGhpbmcgd3Jvbmc/DQoNCj4gIA0KPiAgCW10a19kZHBfd3JpdGUoY21kcV9w
a3QsIDB4MSwgJm92bC0+Y21kcV9yZWcsIG92bC0+cmVncywgRElTUF9SRUdfT1ZMX1JTVCk7DQo+
ICAJbXRrX2RkcF93cml0ZShjbWRxX3BrdCwgMHgwLCAmb3ZsLT5jbWRxX3JlZywgb3ZsLT5yZWdz
LCBESVNQX1JFR19PVkxfUlNUKTsNCj4gQEAgLTM3Miw3ICszODMsOCBAQCB2b2lkIG10a19vdmxf
bGF5ZXJfb2ZmKHN0cnVjdCBkZXZpY2UgKmRldiwgdW5zaWduZWQgaW50IGlkeCwNCj4gIAkJICAg
ICAgRElTUF9SRUdfT1ZMX1JETUFfQ1RSTChpZHgpKTsNCj4gIH0NCj4gIA0KPiAtc3RhdGljIHVu
c2lnbmVkIGludCBvdmxfZm10X2NvbnZlcnQoc3RydWN0IG10a19kaXNwX292bCAqb3ZsLCB1bnNp
Z25lZCBpbnQgZm10KQ0KPiArc3RhdGljIHVuc2lnbmVkIGludCBvdmxfZm10X2NvbnZlcnQoc3Ry
dWN0IG10a19kaXNwX292bCAqb3ZsLCB1bnNpZ25lZCBpbnQgZm10LA0KPiArCQkJCSAgICB1bnNp
Z25lZCBpbnQgYmxlbmRfbW9kZSkNCj4gIHsNCj4gIAkvKiBUaGUgcmV0dXJuIHZhbHVlIGluIHN3
aXRjaCAiTUVNX01PREVfSU5QVVRfRk9STUFUX1hYWCINCj4gIAkgKiBpcyBkZWZpbmVkIGluIG1l
ZGlhdGVrIEhXIGRhdGEgc2hlZXQuDQo+IEBAIC0zOTEsMjEgKzQwMywzNSBAQCBzdGF0aWMgdW5z
aWduZWQgaW50IG92bF9mbXRfY29udmVydChzdHJ1Y3QgbXRrX2Rpc3Bfb3ZsICpvdmwsIHVuc2ln
bmVkIGludCBmbXQpDQo+ICAJCXJldHVybiBPVkxfQ09OX0NMUkZNVF9SR0I4ODgob3ZsKSB8IE9W
TF9DT05fQllURV9TV0FQOw0KPiAgCWNhc2UgRFJNX0ZPUk1BVF9SR0JYODg4ODoNCj4gIAljYXNl
IERSTV9GT1JNQVRfUkdCQTg4ODg6DQo+ICsJCXJldHVybiBibGVuZF9tb2RlID09IERSTV9NT0RF
X0JMRU5EX0NPVkVSQUdFID8NCj4gKwkJICAgICAgIE9WTF9DT05fQ0xSRk1UX0FSR0I4ODg4IDoN
Cj4gKwkJICAgICAgIE9WTF9DT05fQ0xSRk1UX1BBUkdCODg4ODsNCj4gIAljYXNlIERSTV9GT1JN
QVRfUkdCWDEwMTAxMDI6DQo+ICAJY2FzZSBEUk1fRk9STUFUX1JHQkExMDEwMTAyOg0KPiAgCQly
ZXR1cm4gT1ZMX0NPTl9DTFJGTVRfQVJHQjg4ODg7DQo+ICAJY2FzZSBEUk1fRk9STUFUX0JHUlg4
ODg4Og0KPiAgCWNhc2UgRFJNX0ZPUk1BVF9CR1JBODg4ODoNCj4gKwkJcmV0dXJuIE9WTF9DT05f
QllURV9TV0FQIHwNCj4gKwkJICAgICAgIChibGVuZF9tb2RlID09IERSTV9NT0RFX0JMRU5EX0NP
VkVSQUdFID8NCj4gKwkJICAgICAgIE9WTF9DT05fQ0xSRk1UX0FSR0I4ODg4IDoNCj4gKwkJICAg
ICAgIE9WTF9DT05fQ0xSRk1UX1BBUkdCODg4OCk7DQo+ICAJY2FzZSBEUk1fRk9STUFUX0JHUlgx
MDEwMTAyOg0KPiAgCWNhc2UgRFJNX0ZPUk1BVF9CR1JBMTAxMDEwMjoNCj4gIAkJcmV0dXJuIE9W
TF9DT05fQ0xSRk1UX0FSR0I4ODg4IHwgT1ZMX0NPTl9CWVRFX1NXQVA7DQo+ICAJY2FzZSBEUk1f
Rk9STUFUX1hSR0I4ODg4Og0KPiAgCWNhc2UgRFJNX0ZPUk1BVF9BUkdCODg4ODoNCj4gKwkJcmV0
dXJuIGJsZW5kX21vZGUgPT0gRFJNX01PREVfQkxFTkRfQ09WRVJBR0UgPw0KPiArCQkgICAgICAg
T1ZMX0NPTl9DTFJGTVRfUkdCQTg4ODggOg0KPiArCQkgICAgICAgT1ZMX0NPTl9DTFJGTVRfUEFS
R0I4ODg4Ow0KDQpJbiBwcmUtbXVsdGlwbGllZCBtb2RlLCBEUk1fRk9STUFUX1JHQkE4ODg4IGFu
ZCBEUk1fRk9STUFUX0FSR0I4ODg4IHdvdWxkIHJldHVybiB0aGUgc2FtZSB2YWx1ZSBPVkxfQ09O
X0NMUkZNVF9QQVJHQjg4ODgsDQpzbyBob3cgZG9lcyBoYXJkd2FyZSBkaXN0aW5ndWlzaCB0aGVz
ZSB0d28gZm9ybWF0Pw0KDQo+ICAJY2FzZSBEUk1fRk9STUFUX1hSR0IyMTAxMDEwOg0KPiAgCWNh
c2UgRFJNX0ZPUk1BVF9BUkdCMjEwMTAxMDoNCj4gIAkJcmV0dXJuIE9WTF9DT05fQ0xSRk1UX1JH
QkE4ODg4Ow0KPiAgCWNhc2UgRFJNX0ZPUk1BVF9YQkdSODg4ODoNCj4gIAljYXNlIERSTV9GT1JN
QVRfQUJHUjg4ODg6DQo+ICsJCXJldHVybiBPVkxfQ09OX1JHQl9TV0FQIHwNCj4gKwkJICAgICAg
IChibGVuZF9tb2RlID09IERSTV9NT0RFX0JMRU5EX0NPVkVSQUdFID8NCj4gKwkJICAgICAgIE9W
TF9DT05fQ0xSRk1UX1JHQkE4ODg4IDoNCj4gKwkJICAgICAgIE9WTF9DT05fQ0xSRk1UX1BBUkdC
ODg4OCk7DQoNCk9yaWdpbmFsbHksIERSTV9NT0RFX0JMRU5EX0NPVkVSQUdFIGFuZCBEUk1fRk9S
TUFUX0FCR1I4ODg4IHdvdWxkIHJldHVybg0KDQpPVkxfQ09OX0NMUkZNVF9SR0JBODg4OCB8IE9W
TF9DT05fQllURV9TV0FQDQoNCmJ1dCB0aGlzIHBhdGNoIHJldHVybg0KDQpPVkxfQ09OX0NMUkZN
VF9SR0JBODg4OCB8IE9WTF9DT05fUkdCX1NXQVANCg0KVGhpcyBpcyBub3QgcmVsYXRlZCB0byBw
cmUtbXVsdGlwbGllZCwgc28gc2VwYXJhdGUgdGhpcyB0byBhbm90aGVyIHBhdGNoLg0KDQoNCj4g
IAljYXNlIERSTV9GT1JNQVRfWEJHUjIxMDEwMTA6DQo+ICAJY2FzZSBEUk1fRk9STUFUX0FCR1Iy
MTAxMDEwOg0KPiAgCQlyZXR1cm4gT1ZMX0NPTl9DTFJGTVRfUkdCQTg4ODggfCBPVkxfQ09OX0JZ
VEVfU1dBUDsNCj4gQEAgLTQ0OCw5ICs0NzQsMTEgQEAgdm9pZCBtdGtfb3ZsX2xheWVyX2NvbmZp
ZyhzdHJ1Y3QgZGV2aWNlICpkZXYsIHVuc2lnbmVkIGludCBpZHgsDQo+ICAJCXJldHVybjsNCj4g
IAl9DQo+ICANCj4gLQljb24gPSBvdmxfZm10X2NvbnZlcnQob3ZsLCBmbXQpOw0KPiAtCWlmIChz
dGF0ZS0+YmFzZS5mYiAmJiBzdGF0ZS0+YmFzZS5mYi0+Zm9ybWF0LT5oYXNfYWxwaGEpDQo+IC0J
CWNvbiB8PSBPVkxfQ09OX0FFTiB8IE9WTF9DT05fQUxQSEE7DQo+ICsJY29uID0gb3ZsX2ZtdF9j
b252ZXJ0KG92bCwgZm10LCBibGVuZF9tb2RlKTsNCj4gKwlpZiAoc3RhdGUtPmJhc2UuZmIpIHsN
Cj4gKwkJY29uIHw9IE9WTF9DT05fQUVOOw0KPiArCQljb24gfD0gc3RhdGUtPmJhc2UuYWxwaGEg
JiBPVkxfQ09OX0FMUEhBOw0KDQpUaGlzIG1vZGlmaWNhdGlvbiBpcyB0byBzdXBwb3J0IGNvbnN0
YW50IGFscGhhLCBub3QgcmVsYXRlZCB0byBwcmUtbXVsdGlwbGllZCBhbHBoYS4gU28gc2VwYXJh
dGUgdGhpcyB0byBhbm90aGVyIHBhdGNoLg0KDQpSZWdhcmRzLA0KQ0sNCg0KPiArCX0NCj4gIA0K
PiAgCS8qIENPTlNUX0JMRCBtdXN0IGJlIGVuYWJsZWQgZm9yIFhSR0IgZm9ybWF0cyBhbHRob3Vn
aCB0aGUgYWxwaGEgY2hhbm5lbA0KPiAgCSAqIGNhbiBiZSBpZ25vcmVkLCBvciBPVkwgd2lsbCBz
dGlsbCByZWFkIHRoZSB2YWx1ZSBmcm9tIG1lbW9yeS4NCg==

