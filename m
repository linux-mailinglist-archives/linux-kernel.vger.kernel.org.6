Return-Path: <linux-kernel+bounces-554323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16925A59627
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 14:24:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2981016EC72
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 13:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52DFA22A4E0;
	Mon, 10 Mar 2025 13:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="i2b4BBr6";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="l4xjp9kb"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFACF22688B
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 13:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741613004; cv=fail; b=apFCdCgfBJkemaLSnE0nTODIDInJORx4y7w0GnUddlLYwVkBBWUUsUOA6TMQqgzbCAqtveu5y17TA6UPL0CtItCsKZIjMwhIQLw/3DsaOuJxlBzW6jzFHHnZ6sI6xOwJi73xe61h/9DlX1KU3hGGxiC0DmdCMCMRA2Hp7bHD8QA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741613004; c=relaxed/simple;
	bh=XtDiiS7TP/3tqUwqFKVcp22V4iq54FRZJOBJkeBJ5zs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WqoO9hMcEUq89chl3/l7xW/N1XINg5Fi8hGak8xz+2TrhEtiindcwhHeVX/XJbDoxyTGOuKeySr+VVYn3mAfQfF9TOAuj3yAKeZxBOs1H+6LG+TnBHHmYoAR8VjDl7SHPnZdarkGMfsveFscMvgylREpIaBhQER/oeAhvu85ZgE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=i2b4BBr6; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=l4xjp9kb; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: d2a94182fdb211ef8eb9c36241bbb6fb-20250310
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=XtDiiS7TP/3tqUwqFKVcp22V4iq54FRZJOBJkeBJ5zs=;
	b=i2b4BBr6Q/upu2Gvb+8sgd26j/7GmLtBYNPaKGqeSfv0iHs2rOjUciVhtYhmaNr0GgQncTedCGT/o6kz7nfDpGz19fqhhL/2UJdopdyBmahKpqa8c+1slrJaIykTbYHsGbqBtg3tVifTdtnADVmkhg3a5HBXsdM/2S73LkWqTv8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.1,REQID:9c92c1dc-c8fe-4351-a226-112d0a8a27d8,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:0ef645f,CLOUDID:2fbc2f8c-f5b8-47d5-8cf3-b68fe7530c9a,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0|50,
	EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OS
	A:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: d2a94182fdb211ef8eb9c36241bbb6fb-20250310
Received: from mtkmbs09n2.mediatek.inc [(172.21.101.94)] by mailgw02.mediatek.com
	(envelope-from <qun-wei.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 825792964; Mon, 10 Mar 2025 21:23:15 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Mon, 10 Mar 2025 21:23:13 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1258.28 via Frontend Transport; Mon, 10 Mar 2025 21:23:13 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k9EJBMndEI8HEMELyTjCvUJtzfh2E/Ltmkj1qcREKODlb+z570oiFDTwrm2mOZdWNB9vgttzC/vnYc9fT/KDxPD2NqJkT+9eJsz+TRkUnhw2BgWxFjYc4TKtoKV0GRJpfvzr036TvG1gwopPJHeUYJqouOvAXipc6dHi4kVCIj31JxQIdHl5lW5rwFfm+fhfwpsIDfc/FrFHsAgHGbLuTuLjcwowsnB76fgau/9dHlD6QohMMkR73BJGEfuh8HE0TKbfA7A8QLFD5qIrQHLWfESpFJ+XYTvBj+fMwysBYtXkjQ4jT21CcQB3w0/EHKR1vWhhC04y/dSTk1Hf6GgpfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XtDiiS7TP/3tqUwqFKVcp22V4iq54FRZJOBJkeBJ5zs=;
 b=rE7ikt/nJZKOmhEmYTKdQCs03xtQkq2Y915q9euSkRvzQ/MUE/a+qREx4mwGNIA3trdfhY0DPEPbSe2Y+pptfcxwUATDs1KvhHRoO+QthF5Cohflmf5f4M4cNP5FMsWU3staVC3OXo76dFrjXBQIOG2P4gFf3mwOhU4Ss6jdr1nvycawDndAFausB5Xpv9upmhpF4wfbw8gXOf8h1deCmu2QUb/gE5ARCsyIv7jjxoMAu9hBBS3j9/TQ4YPum54drgIBMjwVPDnnjRnt+0Bi0oznofn4VD853HR/c0QOJlq3+ZTaQxb8EkKu4Mg0AyZ9kzZpiwJ7KMSYLR+Amb1P5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XtDiiS7TP/3tqUwqFKVcp22V4iq54FRZJOBJkeBJ5zs=;
 b=l4xjp9kbfCljYkfkMf+IoRpQ/hrqPTY6ntxb9B6fz3N80yvCaaU8yt2lRnIgYqYGnc7WdN+lTeKOMeGl/h5/DktWCoNiNEkM9EvTiAjgBFo8S7bpwQeWW8v59xwKAYeN/QMprWy8cgRvWmGNFUP0Z1XeQpP98GGDdCj84Dx+omU=
Received: from PSAPR03MB5542.apcprd03.prod.outlook.com (2603:1096:301:4e::12)
 by PUZPR03MB7042.apcprd03.prod.outlook.com (2603:1096:301:11d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Mon, 10 Mar
 2025 13:23:12 +0000
Received: from PSAPR03MB5542.apcprd03.prod.outlook.com
 ([fe80::a323:3128:209c:f02]) by PSAPR03MB5542.apcprd03.prod.outlook.com
 ([fe80::a323:3128:209c:f02%4]) with mapi id 15.20.8511.026; Mon, 10 Mar 2025
 13:23:11 +0000
From: =?utf-8?B?UXVuLXdlaSBMaW4gKOael+e+pOW0tCk=?= <Qun-wei.Lin@mediatek.com>
To: "21cnbao@gmail.com" <21cnbao@gmail.com>, "nphamcs@gmail.com"
	<nphamcs@gmail.com>
CC: "hdanton@sina.com" <hdanton@sina.com>, "senozhatsky@chromium.org"
	<senozhatsky@chromium.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH 2/2] kcompressd: Add Kcompressd for accelerated zram
 compression
Thread-Topic: [PATCH 2/2] kcompressd: Add Kcompressd for accelerated zram
 compression
Thread-Index: AQHbj1jervQE5KVJbEeGTu19qWI7uLNoExeAgAA7NQCAAbGsAIABPBIAgAANWQCAABr1gIAA/BqA
Date: Mon, 10 Mar 2025 13:23:11 +0000
Message-ID: <103fe85acd46fcb099a81e435d4cee2826d0357b.camel@mediatek.com>
References: <20250307120141.1566673-1-qun-wei.lin@mediatek.com>
	 <20250307120141.1566673-3-qun-wei.lin@mediatek.com>
	 <CAGsJ_4xtp9iGPQinu5DOi3R2B47X9o=wS94GdhdY-0JUATf5hw@mail.gmail.com>
	 <CAKEwX=OP9PJ9YeUvy3ZMQPByH7ELHLDfeLuuYKvPy3aCQCAJwQ@mail.gmail.com>
	 <20250309010541.3152-1-hdanton@sina.com>
	 <CAKEwX=Mwh9SKWfmaS9q4fym7L-v5m6GmvJrQF8eFizJJd904rA@mail.gmail.com>
	 <CAGsJ_4wFfqFZQw-TOM83gUEV_rN6uio1sujXdjCRKTOipPM2SQ@mail.gmail.com>
	 <CAKEwX=Nfu23j37GLGBXnxgb0N0Hwnk4jVneY=wTSUNQBDTgCXw@mail.gmail.com>
In-Reply-To: <CAKEwX=Nfu23j37GLGBXnxgb0N0Hwnk4jVneY=wTSUNQBDTgCXw@mail.gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PSAPR03MB5542:EE_|PUZPR03MB7042:EE_
x-ms-office365-filtering-correlation-id: 86a85c6c-9411-48cc-ed54-08dd5fd6b4da
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018|7053199007;
x-microsoft-antispam-message-info: =?utf-8?B?WXpQc0ljb2tWaU1QV0xLUkQwUCtYZFZtTHU5MVM5TS9FZDhJZHdhSG95OFAw?=
 =?utf-8?B?enRpNSs3S043Ry9hamo3V2wvU0NzUVdoV1BOT2tQQjh1c0dXa0RyMTRVZ3lo?=
 =?utf-8?B?TUF3M2J4TTFHZUszSlIwZTVZT1RmSUdMZnhIMnh4dWdlcFQ1dFFvWWFGQVEz?=
 =?utf-8?B?YlNoc3dyaXNxNHl1MVR0bjZxU29TbkxHQ0JJcWlBMXU5Q3RHbGxhRjJjM2hn?=
 =?utf-8?B?Z1dqM2F3cWxZQXlOYTNVbGtvTGI3VnlSb1BRUTBrN1pMdmduNll5anZqLzhM?=
 =?utf-8?B?MmRtQ3QrSEV1RFNYZ0sxeGYyT3Z3SGlxT3pWcXNXQ1Q4ak5yTWpHY0Vac1lm?=
 =?utf-8?B?SmxnTnlJVFY4dUk2cWxsaWp2TVRxckpYbkcvb01VVDFEWFBPSS9qWjJHaDQw?=
 =?utf-8?B?MkJmS3UvT2ZGS3FwaWx1dU45K3o4N1Bza0tmSUFPSW9DR1pLellEdFVPNnNS?=
 =?utf-8?B?RlkvK0d6bUZzN3dNL3NjUVZjM0NDU01sUUtjbXpiVXEvaFNreUpMZXJ5QktX?=
 =?utf-8?B?a2pHRElYSFY3REVHaXlYMVB2ZnpJWHRqRFpyS0UvNDY2QS9QL3l0YU5sZWcv?=
 =?utf-8?B?VHJQMDRmaWJIZzdwd2dyTDVFdkNzcTk2bmNNS3JSNm1Gdk5qZ0NiM1hEbXox?=
 =?utf-8?B?UXFFOVFSVFlCTlB3Z25NU0RmVksrMWhXbkxKZ0lYT3Z4bTF3bFJRZlI0K2ho?=
 =?utf-8?B?QWxIS3RTWFNReTlUQTYwMXc4OG5qcS9uQ0M4d21Jck5xOHUxaE5ibWttMzVO?=
 =?utf-8?B?ZUptRkJBd1lCL0xBSmE1ckhEbmhBMXp4ZWtVbkpJcUxXczJvQmF4NzhGMVpC?=
 =?utf-8?B?K0tPanArTnhzOGhjeFgzUXc1MDB1dVJLWEZSTkZ4Nk01VGZOUTlIdnh5clVX?=
 =?utf-8?B?UGtuMzQxVlRwbWt4UlZzNGMzWEVjK3I3YmFxZnhLeTlUMTByN0FhWWEySXM0?=
 =?utf-8?B?NnFxdWI4M0tQQlM1d21nNmVxM3djNlpwZDRVV1FEeC9IbUZGVWwxSzBEVWRn?=
 =?utf-8?B?ajdud0QwTzNoYVdXaFZvR0c2R1RSakkvTnQ4Q0VyTWNETGJiWit4S1JrSE1t?=
 =?utf-8?B?Ly9NT1NhZ3hHQ0tRUHJsRXIrYmFTNi9ndWQ0elVpUUgvR0FPaThtcWtnelpN?=
 =?utf-8?B?OFFuWTczMmhnVUw4endqWXhTbTNtdm9sTHlYTVRpcmxncy85aExOeWVESktG?=
 =?utf-8?B?SllSbzFXZXVVOHFUT2FjcXZuTWo2d1UwS3pTTGpZc09DeDEybmZNSnBuYUgy?=
 =?utf-8?B?VXJlNGp5S0pzRVRaQldJVkFrRTMxSHB2STZmVmgvUnFGS0RsRHVOVTFFRUI1?=
 =?utf-8?B?ZzJialBsYVJFKzRSdWFneWY3QVBqREdUUm9HQ2JFZkpwd0VuRlh2WmVVOGVu?=
 =?utf-8?B?Vlp1WG1USnVVRm5ySERxbng2N1gyd1ZaVzNqYXIwL21wMXIybVdKMzNMZ0FJ?=
 =?utf-8?B?UXRnbEpEZVZSN0kvOHJQSXRXS3ZESjh6WGkrcU40WjNQR2tnOWVHRHl3dktv?=
 =?utf-8?B?c0ozMnExeFFpa1UvTGpKczQ3MXVsSmZUV1d0ai83L3BLdStZNU9XQ09RNUxJ?=
 =?utf-8?B?aVZQNWlOdlBTMkVnalhGd04vMFF1R3dPQkRHVTRVRWNseEdiMlBqL2o1Ui94?=
 =?utf-8?B?aURaSW93Y2FvZE5UZU96eXU4ZnpnbFNkK3hFdUc4L1psNnNrWm1zMW1PMVpO?=
 =?utf-8?B?VHBKTHYwMHRnN3A0Tml5TEtteWJYaVZ2YVdmMHA4NWpxZC9PSDdvemhkUG0w?=
 =?utf-8?B?dFZmRSs3NFZKUkRGOWhoZXgwclNZSXRNUzdjak12b0hsRnJZRWtqZVBsNlRu?=
 =?utf-8?B?d3dVWlg1VHA4Y0NDWElRV0pFS0NhRUJ5WWNMeHJwamY5K0JwbHcrOXlVVWwv?=
 =?utf-8?B?emZTMzcvWXZDYVowUVI3VkRFRVg1dW1COWdRZGZ2NXFySHRkbGY5MGd2TXUw?=
 =?utf-8?Q?q1orLOBztfyD1sHAUrbxcsTknMHD2XlV?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR03MB5542.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NjE3bUNUM09HZXJuUEZsQ08xYUYwRllJenYva1dPWGtNOW50dHdBdWhNaE1D?=
 =?utf-8?B?dEVSNi8rR1JLcm03L2dxaDJ6bmI5dUYyMnUva3NsZU9yMEN0UnRkRERPTkpX?=
 =?utf-8?B?VmFISGVTRitUSlFqVENOK1VtT0lNUmU0ckdlVWNGRE9valZHZlFSUnMwVTlx?=
 =?utf-8?B?MmlkRk8zQXNVanpxRmpEVEpZS1pzb0dOay9lRWRHTVd1RnRxdnRiWFY5aUJ3?=
 =?utf-8?B?ZWhuVDJFTk0vYkFwM0VQdkJSaGN4dzNPZkk3N3h0ZTg1QUxRcnc4WTFKcDlV?=
 =?utf-8?B?ZEphSGV2SzdOTmdsVC9ubHMxVW5xMTJkU0tkQ1MzSVJYbmJTUmp4MXJweWox?=
 =?utf-8?B?VmRWVWl4RTJZWk5lY294QVFNQ1d3aG1TZlBRMHBTcCtYZ0dEcEtvRE5zbjZQ?=
 =?utf-8?B?dVVER3VTQUNaU3hlQWNud1NyOU0wMFBuUjBOd3NDSjVtUHl3dDMrT1c5S3pt?=
 =?utf-8?B?aFh5eUNtcE5oNG9jRU9taE0yVFA2UlgvZ2JlZE5sUURZOWF6cGVsMUg5ZzJM?=
 =?utf-8?B?aEZBL1VQQzIyU05tcTYwYVJBZXh3TlZGZXFSNHBUekZSUHcwMVpWamFGV2o1?=
 =?utf-8?B?bGw0SGxvcTI1VkczWG1laWRtS0t6aEZycU9USGdOSUQ3UVhVVWxXVC9zYmd3?=
 =?utf-8?B?MnlrM3N2Y2tSTkNLNW0rMVhDYnUzYkI1VjVPOE1FV0pVSCtyU2Vxc0o5bFRB?=
 =?utf-8?B?L2ZhcGdkcFhTYkxVTkIySkJDR2QyZHduVGYzSCtQWXM4RDhtNmN4SDhtcHBs?=
 =?utf-8?B?cUttbFRmYkJTZktycUVpaHpURmZqVU1WeVFIeVJmR294bUZ2NEozaFRYVVJQ?=
 =?utf-8?B?c2trQmorSzJUdjJ5QllUWmljVGszTkdMd0J4cGRLSUZoQVhCeDFYY05FVXE4?=
 =?utf-8?B?Y0o3eXF3a3R4bCtSSTZHVkFiTUtROGJvVjQraEhhcjVxYjUxd1B2akVnTzVT?=
 =?utf-8?B?QXk2K0xVQVR4TTFXeTVvUUg0RGF6LzBtZFU1MDRKbmpaM2JHMkx4bHVpN29P?=
 =?utf-8?B?T3ExaU5vRWdReWthZUN2ZCtJWGk4UXcreHExODJScy9SdDlQNXBSbDVIVGFw?=
 =?utf-8?B?cUZON0Z6OTRWc012ZUlPaWZFeldubUZEaVN5dHMvVXFwSm9QbFJUajhra01y?=
 =?utf-8?B?Vm5aSExuWUtDYU4xNlY2MStZQmtKOTF4dmZvMytBRENwTTY1eElTcEVvNzJr?=
 =?utf-8?B?TDN0QVRlaVFyQUhTa2FLQS9sRlZkcFJNMW85QWtNMXQyNXU2bzM1c0RwOW1w?=
 =?utf-8?B?eXMzdHl6bmVJTmNQRGI5bWNEY0pNZUJBVmRxb0k1cEIyanU2U1BRT3F4ZlUy?=
 =?utf-8?B?dk9RZEtBSmRVSTQ5WXF0U3NvZDAzUnk4RWxUcDdYdHJCSWNFeHI3TDNLMTFZ?=
 =?utf-8?B?dnd0UUxabWFXbitHTHVZdnFPMTVBcTRGOUdwejNGQWdIK2tCTHlDdVhyWHRn?=
 =?utf-8?B?QUkyc3dnMFdCWUJ2WFEvWGZ0L0hlTGVVb0czeXJUT2E2dUVnWDdKYTJjNmVJ?=
 =?utf-8?B?YWVQOVdRUjhLSU5hak40V01VWjJ0SmpRYmF2RDVBNElzZmZVUXVxL2djV1Yv?=
 =?utf-8?B?THhZQXBLRU5NMGFTWDF4d1ZmU3JRRHRMcTRiSGpBeWpDbzVvelc2NFVSN05p?=
 =?utf-8?B?SDBRbldRaStuM1Job3Nia0NRWWNuZzdQR3VIaWhMVTJLNkRSUSsxT09Vd1RS?=
 =?utf-8?B?N1BEWXgvR2tOWkVLTW93UjBRS2xLRlZ3S0xUWGU5blJrOURWRWhYWlN4cmI5?=
 =?utf-8?B?bUNVaC9kQndxNlRvYmMyaVdmTndJejE0QnJmclVaL256MXBDZTBOOFlWQ3Nw?=
 =?utf-8?B?dkp2amxabkRpdGpFRDJyUS9FZnNXY3BtOXFYNG96QnRoQzNVSi9obkRMTGxQ?=
 =?utf-8?B?Q1dXQzRBU1NSWFkwNGttS0JCREN1c1JkWG9PcFd4RjNlQ2lZNTlCcEhzRFZi?=
 =?utf-8?B?eENOTEtNTWFvMVA5ZCtmL1krT0JLd3VrdFdST0h6OHVNUzBCTVdqTVo1NmJo?=
 =?utf-8?B?RWdTMmdNNzhHUzFGQ1MzT0ozZkxCbFI3VVcvcWMzVytReEJIWm96WDZ6M2pm?=
 =?utf-8?B?RzJuZkI5dUw3ZTUvT09lSkgyUkJ0V1pKTnNSREFoTkN3WkVPVUJaY0d1ZHBh?=
 =?utf-8?B?RGo0SnNFV1B6YnFFSTFvUEJpdHJmY05rVk9HcTV0dDFmQUdZK1VxZTBxck5p?=
 =?utf-8?B?Vnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <ED57EE43D9D9044A8F9E0207D6E3CDB5@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PSAPR03MB5542.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86a85c6c-9411-48cc-ed54-08dd5fd6b4da
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2025 13:23:11.8265
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D9lboyhAo8Yc7GmZcddSRILl29en/pqk5KrZ9y6l6vcA2t1cLT3JdSssqQ9mkjWwkBJZVtiXLfGopGh8tS4YdZoFP1F385FLtw9/jcLE3lw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR03MB7042

T24gU3VuLCAyMDI1LTAzLTA5IGF0IDE1OjIwIC0wNzAwLCBOaGF0IFBoYW0gd3JvdGU6DQo+IA0K
PiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRh
Y2htZW50cyB1bnRpbA0KPiB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVyIG9yIHRoZSBjb250
ZW50Lg0KPiANCj4gDQo+IE9uIFN1biwgTWFyIDksIDIwMjUgYXQgMTo0NOKAr1BNIEJhcnJ5IFNv
bmcgPDIxY25iYW9AZ21haWwuY29tPiB3cm90ZToNCj4gPiANCj4gPiBPbiBNb24sIE1hciAxMCwg
MjAyNSBhdCA4OjU24oCvQU0gTmhhdCBQaGFtIDxucGhhbWNzQGdtYWlsLmNvbT4NCj4gPiB3cm90
ZToNCj4gPiA+IA0KPiA+ID4gT24gU2F0LCBNYXIgOCwgMjAyNSBhdCA1OjA14oCvUE0gSGlsbGYg
RGFudG9uIDxoZGFudG9uQHNpbmEuY29tPg0KPiA+ID4gd3JvdGU6DQo+ID4gPiA+IA0KPiA+ID4g
PiBDb3VsZCB5b3UgZXhwbGFpbiB3aGF0IG5yX2tjb21wcmVzc2QgbWVhbnMsIFF1bi1XZWksIHRv
IHF1aWVzY2UNCj4gPiA+ID4gYmFya2luZyBsYWRzPw0KPiA+ID4gDQo+ID4gPiBXaG8ncyB0aGUg
ImJhcmtpbmcgbGFkcyIgeW91IGFyZSByZWZlcnJpbmcgdG8/IFBsZWFzZSBtaW5kIHlvdXINCj4g
PiA+IGxhbmd1YWdlLg0KPiA+IA0KPiA+IEkgYWxzbyBmZWVsIGV4dHJlbWVseSB1bmNvbWZvcnRh
YmxlLiBJbiBFYXN0ZXJuIGN1bHR1cmUsIHRoaXMgaXMgYW4NCj4gPiBleHRyZW1lbHkNCj4gPiB2
dWxnYXIgd29yZCwgbW9yZSBvZmZlbnNpdmUgdGhhbiBhbnkgb3RoZXJzLg0KPiA+IA0KPiA+IEkg
c3Ryb25nbHkgZmVlbCB0aGF0IHRoaXMgdmlvbGF0ZXMgdGhlIG11dHVhbCByZXNwZWN0IHdpdGhp
biB0aGUNCj4gPiBMaW51eA0KPiA+IGNvbW11bml0eS4gVGhpcyBpcyBhIHNlcmlvdXMgY2FzZSBv
ZiB2ZXJiYWwgYWJ1c2UuDQo+ID4gDQo+ID4gUmVnYXJkbGVzcyBvZiB0aGUgZXhpc3RlbmNlIG9m
IG5yX2tjb21wcmVzc2QsIGl0IGlzIHN0aWxsDQo+ID4gdW5hY2NlcHRhYmxlIHRvDQo+ID4gaW52
ZW50IGFuIGludGVyZmFjZSB0aGF0IHJlcXVpcmVzIHVzZXJzIHRvIGZpZ3VyZSBvdXQgaG93IHRv
IHNldCBpdA0KPiA+IHVwLCB3aGlsZQ0KPiA+IGtzd2FwZCBjYW4gbGF1bmNoIHRocmVhZHMgYmFz
ZWQgb24gTlVNQSBub2Rlcy4NCj4gPiBUaGlzIHNob3VsZCBiZSB0cmFuc3BhcmVudCB0byB1c2Vy
cywganVzdCBhcyBrc3dhcGQgZG9lcy4NCj4gPiANCj4gPiB2b2lkIF9fbWVtaW5pdCBrc3dhcGRf
cnVuKGludCBuaWQpDQo+ID4gDQo+ID4gew0KPiA+IMKgwqDCoMKgwqDCoMKgIC4uLg0KPiA+IMKg
wqDCoMKgwqDCoMKgIGlmICghcGdkYXQtPmtzd2FwZCkgew0KPiA+IMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBwZ2RhdC0+a3N3YXBkID0ga3RocmVhZF9jcmVhdGVfb25fbm9kZShrc3dh
cGQsDQo+ID4gcGdkYXQsDQo+ID4gbmlkLCAia3N3YXBkJWQiLCBuaWQpOw0KPiA+IMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAuLi4NCj4gPiDCoMKgwqDCoMKgwqDCoCB9DQo+ID4gwqDC
oMKgwqDCoMKgwqAgcGdkYXRfa3N3YXBkX3VubG9jayhwZ2RhdCk7DQo+ID4gfQ0KPiA+IA0KPiA+
IE9uIHRoZSBvdGhlciBoYW5kLCBubyBvbmUgd2lsbCBrbm93IGhvdyB0byBzZXQgdXAgdGhlIHBy
b3BlciBudW1iZXINCj4gPiBvZg0KPiA+IHRocmVhZHMsIHdoaWxlIGRpcmVjdCByZWNsYWltIGNh
biB1dGlsaXplIGVhY2ggQ1BVLg0KPiANCj4gQWdyZWUgLSBob3cgYXJlIHVzZXJzIHN1cHBvc2Vk
IHRvIHNldCB0aGlzPyBUaGUgZGVmYXVsdCBwdXp6bGVzIG1lDQo+IHRvby4gV2h5IDQ/IERvZXMg
aXQgd29yayBhY3Jvc3MgYXJjaGl0ZWN0dXJlcz8gQWNyb3NzIHdvcmtsb2Fkcz8NCj4gDQo+IFRo
aXMgbWFrZXMgbm8gc2Vuc2UgdG8gbWUuIENhbiB3ZSBzY2FsZSB0aGUgbnVtYmVyIG9mIHRocmVh
ZHMgaW4NCj4gcHJvcG9ydGlvbiB0byB0aGUgbnVtYmVyIG9mIENQVXM/IFBlci1jcHUga2NvbXBy
ZXNzZD8NCg0KVGhlIGRlZmF1bHQgdmFsdWUgaXMgYWN0dWFsbHkgZGVzaWduZWQgdG8gYmUgdGhl
IG1heGltdW0gbnVtYmVyIG9mDQprY29tcHJlc3NkIHRoYXQgY2FuIHJ1biBzaW11bHRhbmVvdXNs
eS4gVGhlIGN1cnJlbnQgZGVzaWduIGlzIHRvIGNyZWF0ZQ0KdGhlIG5leHQga2NvbXByZXNzZCB0
aHJlYWQgd2hlbiBhbGwga2ZpZm9zIGFyZSBmdWxsLCBhbmQgdGhlIG51bWJlciA0DQppcyBqdXN0
IGEgdGVtcG9yYXJ5IHNldHRpbmcuIA0KDQpZb3UgYXJlIHJpZ2h0LCBjaGFuZ2luZyBpdCB0byBt
YXRjaCB0aGUgbnVtYmVyIG9mIENQVXMgbWlnaHQgYmUgYmV0dGVyDQp0byBhdm9pZCBjb25mdXNp
b24gb24gaG93IHRvIHNldCBpdCB1cC4NCg0KDQpCZXN0IFJlZ2FyZHMsDQpRdW4td2VpDQoNCg==

