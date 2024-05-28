Return-Path: <linux-kernel+bounces-191896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A2528D15B3
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 10:00:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 702D61F2244A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 08:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 819F984D30;
	Tue, 28 May 2024 08:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="dZau2AVy";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="uOqWNlnS"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A814F4EB
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 08:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716883216; cv=fail; b=kBAjn2+XV3rptxmIVyE7MKbS0foTmvJAH26HroOMu8GFiPjoJr0XlWf5phvw8snIDy4yk/M6J69YkbTAGGCib25lSyfjBvbSCFOZ5ekP5S/ZYnmUMud06V5o2whN84krGBBI5wpd9oxxsiT7zPqWXUBw1Go+2lC0ShrPcJTF2OU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716883216; c=relaxed/simple;
	bh=Th3OM2UDlFGE/sO6GzVeUgtMvQNYqTfLlKGSDdlVWkc=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=MfkBGw0GUy0iHupfj8NJ5MVsRaqV5hcGJ9g6NmtCYgDp0hZZg1xW5TSel8FqQD29IGUtvgAdZYt4QEKqUmuP7mcSmV5fe8QmuNERoPeQul9UEllCho7Iil/m0TYIgh2YpQq26AKMrVTFzJqXuPtlvA/6422TBeGUPhkz7ID1C6M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=dZau2AVy; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=uOqWNlnS; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 4c727faa1cc811efbfff99f2466cf0b4-20240528
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-Type:Message-ID:Date:Subject:CC:To:From; bh=Th3OM2UDlFGE/sO6GzVeUgtMvQNYqTfLlKGSDdlVWkc=;
	b=dZau2AVySeV7kEaciZw7IuFsODc7yaobMZY4dFa1/zgh2Tl2BW/VzEzPpLbNXqvXLxP7YrXungfj32ROgG55KkoHtC2NyEHLs+rlu87eTqqFNqCrlsZ2orxNIUfUk6e4pE1Y23Z+7zzqYfzeSrmX7SxXWFpyBHr8cLtghlbJRA0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.39,REQID:82074bdc-ad53-4cda-899b-f690cc3d6f84,IP:0,U
	RL:0,TC:0,Content:0,EDM:-30,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-30
X-CID-META: VersionHash:393d96e,CLOUDID:7c97e543-4544-4d06-b2b2-d7e12813c598,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:2,IP:nil,UR
	L:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,S
	PR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 4c727faa1cc811efbfff99f2466cf0b4-20240528
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
	(envelope-from <jia-hao.bai@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 887689488; Tue, 28 May 2024 16:00:07 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 28 May 2024 01:00:06 -0700
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 28 May 2024 16:00:06 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LQ+D6oXRfcqz/q9agShzO9vdfOWu93Nlomhyu3If8l7KSF9SHFQrXEWc5BDLr0r2+qoSQOn1IErsREc9HzH6OlVfvpoJzQWpQV+ngvm8Q7o/FEoUgWDrV/pbco4oloojrUADFw2tjdF6ip6yRtSh6jMwBsHRL9Qd+XitwvRzF+h4c/TW9KMujtjmWQWBtWplyYlmBdc3l3lxj2cV3c5ZqGC0TYcjfBSwgn52up4yTrgq2NLdW2VT3PTorHNRT+kvpTHgmJ/VOzyVANw0Q9v5HTv0wZOx9GRAHRXMtsKRdq4n7MT4JQyqYHtbW5wk4Gv1ZpD1I6ZLrWN5hUY5HMlYMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Th3OM2UDlFGE/sO6GzVeUgtMvQNYqTfLlKGSDdlVWkc=;
 b=hCro9OOJM6zUh47FT5oX56aGy4OwTpamqbkmRI+VOO/VLHYKAqvfmdiZUdZeMIGXnhPxl9oy0zh2UaJuDAUp6IBiJsoQczu1Y0w7sPchsCGGLim/EtHN6Kw9AlXut+nFonuOH+dIp+/Pl4mlO954cZRhGvSETM/1sHFfcIUkzoede9cHyiNw2BmJmxyJRTOInfouM/udBNEtwFoKMe5q9MSTtIe4pesJUpM7Ojce2qmzm9X8Fk9dp20yYJ/0De7aL4tesSmQQFsDEYQtI/CEhjNZwdoJQQ3EyuFZEM0Ekxy9lVGCd12lMzraLpLL7Lfbr34Y5xSB897P9LfXSkUVqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Th3OM2UDlFGE/sO6GzVeUgtMvQNYqTfLlKGSDdlVWkc=;
 b=uOqWNlnSA9ZPW7Vd/OYF7sC1+rmNsoxD7qi6l4jn7Zgng8Mt7N9XoZUnkjTH0JFxfEby1yxjtG+uq6pWeXXIPAxQFelKCuk+41qpyeQ+sAQT0iDd9cyEKR/wEEBO/UQQVodDYBSJ1/HaCmtLESMNp/KAn2cXzB9ikpl3lcAssxc=
Received: from KL1PR03MB7037.apcprd03.prod.outlook.com (2603:1096:820:da::8)
 by TYZPR03MB7963.apcprd03.prod.outlook.com (2603:1096:400:451::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.13; Tue, 28 May
 2024 08:00:04 +0000
Received: from KL1PR03MB7037.apcprd03.prod.outlook.com
 ([fe80::c81d:4998:1ec9:b37e]) by KL1PR03MB7037.apcprd03.prod.outlook.com
 ([fe80::c81d:4998:1ec9:b37e%6]) with mapi id 15.20.7633.001; Tue, 28 May 2024
 08:00:03 +0000
From: =?utf-8?B?SmlhLWhhbyBCYWkgKOeZveWutuixqik=?= <Jia-hao.Bai@mediatek.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"rafael@kernel.org" <rafael@kernel.org>, "pavel@ucw.cz" <pavel@ucw.cz>
CC: =?utf-8?B?SXZlcmxpbiBXYW5nICjnjovoi7PpnJYp?= <Iverlin.Wang@mediatek.com>,
	=?utf-8?B?Qm95IFd1ICjlkLPli4Poqrwp?= <Boy.Wu@mediatek.com>,
	=?utf-8?B?U2VpeWEgV2FuZyAo546L6L+65ZCbKQ==?= <seiya.wang@mediatek.com>,
	=?utf-8?B?RGVuZ2p1biBTdSAo6IuP6YKT5YabKQ==?= <Dengjun.Su@mediatek.com>,
	=?utf-8?B?V2luIFllaCAo6JGJ5piM5YCrKQ==?= <Win.Yeh@mediatek.com>,
	=?utf-8?B?U293ZWxsIFBlbmcgKOW9remmluWBiSk=?= <Sowell.Peng@mediatek.com>,
	=?utf-8?B?UmljaGFyZC1DQyBZYW5nICjmpYrogbfpipMp?=
	<Richard-CC.Yang@mediatek.com>
Subject: [BUG] Kernel panic when using Hibernation on kernel 6.1.25
Thread-Topic: [BUG] Kernel panic when using Hibernation on kernel 6.1.25
Thread-Index: Adqw1J9Y/DIFBWg0SV+jdgPf4fUPYg==
Date: Tue, 28 May 2024 08:00:03 +0000
Message-ID: <KL1PR03MB7037E7FDCC426ED77C917910C6F12@KL1PR03MB7037.apcprd03.prod.outlook.com>
Accept-Language: en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB7037:EE_|TYZPR03MB7963:EE_
x-ms-office365-filtering-correlation-id: f39fd79f-ea0c-4392-cb7c-08dc7eec2e83
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?WlNla1gva1BOS1lyM0Q0dnY1VVRMaGp0aVdqV2hIcHM2MFBNeFgzNU1JS01Z?=
 =?utf-8?B?bXJkaXY4REFIUytsVkVEcUh3aFhTbzVhWHczWW1EdUMyT3RFUHNDMFRmMS91?=
 =?utf-8?B?dWtZYWdnWVpUSytuSE14UDV5ZnR1bTRuTHpEWHh6MUpucC9ydkcxdDBuK21z?=
 =?utf-8?B?Zjgya0pQaGJjNi9CRlJHOE1sQWJiT3JQank3NEQ2c05vQTdvRVVKazF5YzNY?=
 =?utf-8?B?WmwxUXIzVDhBUDhERU9BZUJHbldpTGlSdzRWSDJvbGFZZU5XVExHWmEvM2RE?=
 =?utf-8?B?Ly9mbUU0WWpJMkpyOHJjS0kvcTliQ1Zaem9PS2ZMUW8veHRsTG41bWNRVkVz?=
 =?utf-8?B?MXFmVGJobnl0Z25FYUlucVo4ZUxzR2U5K3JzUkVQREp2VHBtNHBDS3Q4KzdC?=
 =?utf-8?B?YVJndnpZMnl1WG4xMndINWY5Vmk5RlhhSUVuRmUrTDhxeWtmNFFMVGRpY3VC?=
 =?utf-8?B?ZGZNN2J4YUJsQ3l5NVd5OTl0anhybGdFWUIwWnNNQno1dDFndEpJcnM1Z0py?=
 =?utf-8?B?L0UxaXBHNWVpd0VOdXp0NWdGdWZ4aGtjbjcrWGZwb014eHhlVUlFaDBHYXY1?=
 =?utf-8?B?anZXaW5VNVQ2TGdUMXlmT1ZSc2dMTERHYTdjd2hZREt2MmxuZnlkdGlPdUhq?=
 =?utf-8?B?TkthQXF2anZMV1hSKzVnSm1rL1JwN1R6Sjg0V3pDNUFmS3RtN1FQWWNGaTlk?=
 =?utf-8?B?M1p5N1M3VUtzYWU5aEs3cVA3Z2hmVWt1c25OWlVjdFdnUHdtZkpCemozZVd0?=
 =?utf-8?B?UGZhcTEvTWpwcjcxbjkyU3RvYzlEME9EdU8zWVE3eXV2eE9oMnlta0pkbTNE?=
 =?utf-8?B?TlBHZVdSSXpCOHRxMGZOWXlaVDVQb3B6aStSOEhoRW9OZk9kSjVSdkQzd0ZZ?=
 =?utf-8?B?ZHVheXFBcGFXU1N6SGQ0eVRVcXpTaG5zc0pRWnN1eE1SYmY4VmVlcWcyL3Za?=
 =?utf-8?B?NGVqdDBTd2Q4YW1mT09CZ0RlYnorNmhDaUxOVUxUQzdRY0lSZ0xXdUducmxG?=
 =?utf-8?B?R0d0cXpKK2ZCT004Y2tGTGhScXhNeW90YjRndjF6OHNKV1BmQXZ5U2p4MFNY?=
 =?utf-8?B?U0lqRGEzVHVnaDNSUzlvYkRtelhrNGlOR3NyVHlBZXdiSnNVcEpUOS9EL0VH?=
 =?utf-8?B?enAvb0xWdGRCejlMQ3FCbUFoUVd1S0hRUFZVcHo5MmhGZ2VkNy9VWGVsU3Rs?=
 =?utf-8?B?R2h1N2NDbU5Vb21uN0JORUdtcDVPWU92S2RnRGZZVUpYOTNZUkJYUDN5UHBV?=
 =?utf-8?B?K2liTklzRTI5NWV3cit2L01XNXd0aFBYck1kNjZiQUxuTW5KZnoxaTVRYTdo?=
 =?utf-8?B?b096NFVhaDNuSHEwQU9Tcjc0Y1g3YWxPRE5RK1JrajdOUnlmOHVpazZWMTNN?=
 =?utf-8?B?YlduT3E2SkY4NWFhdTRIcWpJODRuSzlZTlpGSzlCeTFUMnBlK2xCVUR2VGVP?=
 =?utf-8?B?bVFibjRWVzNTNnd6dCszQ3M5Uld2UzMxSElJdDhPSlVQcG9jWHBQdGRtdjRQ?=
 =?utf-8?B?ZUVRanp1RXVpQzk1S1ZPTXhnZ21qVWNydHZmdzNTZTJiZi9YUFdHK3ZlVVVB?=
 =?utf-8?B?OGd2VGZhdTJOYlhjVlcvT0Z5dzlmV1Z2YU9ub1VRL1MvWFhMOGlMc25BVGJ6?=
 =?utf-8?B?Wkl6dTU1QzJBbmw4em5lWTVaRWdHUmErNVdpOVJvYjJEQ1lKb2t1VEpTQnpV?=
 =?utf-8?B?Y01PNmpHSktxcmlRZTl6UVdWOFF5clFTTm9RQ2tRT0NtZWxHaXFWd0hVMUtL?=
 =?utf-8?B?eWtmNFF6bnM0U01qNEdUNFloWW12aUpUaWNHY05pLzJBeU45RXlFdGZua2hS?=
 =?utf-8?B?bG5rRC9kZ1pMSU0zOTU5UT09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB7037.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b1p3OU5FTE9MbGZINzBBcGQrZ0phMklqeUpGWGhkdys0WERyQmxUcEdsVXpQ?=
 =?utf-8?B?UERFWUFkU3plcXU2eEd6Zm02c01tRHNiaUpIT3VKbU5aK2x5RjIybTJ0UnNL?=
 =?utf-8?B?dmNITW5ZKzVDcEtadVFadzdFTnZidXg0TkJYeGN0dk14dWJHclY0dU14NlZh?=
 =?utf-8?B?OHdVZ3c5YU81bEtVVTlaRjcxUTZuUWF3K3RKemtWdUgrM0VFendIT3UvWkx3?=
 =?utf-8?B?WG5kdmxFaUt0Rkc3MjlMMFo1Qm0zZ3QrMmdNOVl5Q2dEMkl5RSthaUR1QURi?=
 =?utf-8?B?VEdzSU9MRGhaQ3lMOVdrZnIwVDVTUTV2ZEs1b1lvYU9zbGMxZDhHekJQK2Nu?=
 =?utf-8?B?Q3pDcE5mMXc1OGVqZlZzSE9QQlJuems3aGt5QlhLWHkydXorVjNjU3lHZ1FM?=
 =?utf-8?B?Y3dsSjZUTE1GTWYyc3lOYkJqY0U3cUw4QWR0NG5yOXkxYkRtUjNrOFdtbXpR?=
 =?utf-8?B?ZUZMZHVsSGovNDZ0UVdJOTcza0pUN2diNDlzYkNZUkFUVUxBcHA4UUZDMmky?=
 =?utf-8?B?cXFPL1B6dnpOUU9Yc0lsZVhMSFpiVDRZNkNocWJIRlBSUEZnRHFHUmFWRjhv?=
 =?utf-8?B?ZzRGT3dzRWZ4Z2FVRUFHMlNwVk1Yb3V2VFd4dUM1TG1sYVRpbitseE5kbjlx?=
 =?utf-8?B?My93NVVMdm9MS1J1cGhZQzBvSW1BZ3RGZm44VkpuRHB3Y05ZTGkvWjhUZWFw?=
 =?utf-8?B?ajVBVzIya2ZIblRzVUdSTExSK1ZtSmhaQVJXcXhwV2VzSFNtM3FqcmE2WDda?=
 =?utf-8?B?TmM3TW5kSzQxaHZ3b2pubTVvL2tHdGtsdXFYdFo2Nk9TdWJZY1hYSkhVL1li?=
 =?utf-8?B?bSsybFhKaG15L0xCOTZZRU9RVkdQQXBSbVhJOC9ZWGZMcVBoaHc5aEpmWFJo?=
 =?utf-8?B?dDA2WHZsRks4QjdsQUsvbUtSSTQ2WnY4M2hZSzdvazFOSzRoMEl2YkJDU1hh?=
 =?utf-8?B?Kzh6bW1tQkpNaG43SlU4WFp4Q1I3UW5SbnNzYXYyZXRYNzVvSk9tOEpWUldu?=
 =?utf-8?B?QUo5K2xwcWtVUkdIZ3BaTUZpdEJ6WjBDY2tsSFVBVmphcUhjMkpFdVRIcmNY?=
 =?utf-8?B?dE0wNmtpc1ErcDloZUlySEJOUUR6OE9WSE9Da2RjL2k3bi9ESC8zVHduSll2?=
 =?utf-8?B?TW93bXArZk9mNndHdlA3eHhGUGdYb0hjUkJYaDRPWWlQa0RBbDU5Tkl0V1V2?=
 =?utf-8?B?c3lDNjdIWmZIODFsV1BPK01rb2RvUndMeSsreWkrb1FNQjRIM1c3cTF0UXJ5?=
 =?utf-8?B?TXM0TEt5aExCT2QvL0VjVEc5Zm5PYXFnT091Q1hMTkN0eHJoN1Nxcm5DU1NT?=
 =?utf-8?B?d3F6ZjZyWVp5am5Uc0VTd0g0NFpsN2ExbldLNHRtZm5Ba2VwYnE5aU41cE1H?=
 =?utf-8?B?SGpJb3RObkhXS1o0N0RiVnZJdkJRamhUWndPWVJzSHh0TXcrR0kyTkV6WFNK?=
 =?utf-8?B?clZBMTBEZmhqS3lQdzd5TjR1dmk2djlrTkRZSmxCc1Y3UERuVCtkZG1waHJk?=
 =?utf-8?B?bGdTTGhUampOOCtsTnJGSm9NUkNKOEJ1SzFEZ25QTGRobm5VOVZxR21UQ3k4?=
 =?utf-8?B?Z0g3YzJRSUlwd3EyRUhEZnFJS3BrUzMvTDcxT3Jvb1Z2S1ZITkhxaWxDYVpF?=
 =?utf-8?B?WWRUL1hkRjZXbXBDSktOWmZKZ3VMQ3NpWmhZSVFUVXlLTUNtN1prOVpoVVJF?=
 =?utf-8?B?TmUxZ0RGeEVCVmJvZlp2Yi80NXpFUDkwcDdwY1M2K2FhS0lSYUhFWWF1bmZ2?=
 =?utf-8?B?L3hsdDRMWGlPSkVtaXNpRkNRM1JvblBtd2tQQWV3cHdHZkV6L1g3VDFCZjNm?=
 =?utf-8?B?Z1FkMWlkdytYR0JiK2ZpTUlqVVpUTEJaWVdkaVBJQ0prVFNudFFjRWhOdEdX?=
 =?utf-8?B?TCsraW43Zmx2amJiWnF0WktHa2dPaE4vNkhJcytXSjlrSkIzVm5JblRCNkVJ?=
 =?utf-8?B?bWlNRCsxelJRQlhiMUo1M0xhZVhqMUphRmFZQnZpWmNBNU9FNW45aHZ2c0xi?=
 =?utf-8?B?OHJDYWlzcXdWYjVoRnVuZGdkVzJMSkpFQXF6eVhlQmREaEtEQUdHVHAxSVRh?=
 =?utf-8?B?NmNKdHJsM3hDTkx6cTl3TkQxRmVkRlFnRys2M1RlZjNZNjF0UGcvNXoxUmFR?=
 =?utf-8?Q?tSg6utS/Dq/LcYhbbRSODzmQq?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB7037.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f39fd79f-ea0c-4392-cb7c-08dc7eec2e83
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2024 08:00:03.6901
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J/RMxPl8MNyaz9LXWF056a3JCSpiCDVzfky4+foTAcX85/0VsD06952ukxCaKy3zi4hxRS3Z74L17GqWbc0U8GhRmNKk5MBNl5NbXdAmcMY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB7963

SGksDQoNCkkgZW5jb3VudGVyZWQgYSBrZXJuZWwgcGFuaWMgd2hlbiB1c2luZyB0aGUgSGliZXJu
YXRpb24gb24ga2VybmVsIHZlcnNpb24gNi4xLjI1LiBCZWxvdyBhcmUgdGhlIGRldGFpbHMgb2Yg
dGhlIGlzc3VlOg0KDQoqKkRlc2NyaXB0aW9uOioqDQpXaGVuIEkgZW5hYmxlIENPTkZJR19ISUJF
Uk5BVElPTiBhbmQgYXNzaWduIGEgc3BlY2lmaWMgcGFydGl0aW9uIGZvciBoaWJlcm5hdGlvbiBy
ZXN1bWluZyBhbmQgcGVyZm9ybSBhIHNwZWNpZmljIG9wZXJhdGlvbiwgdGhlIHN5c3RlbSBjcmFz
aGVzIHdpdGggYSBrZXJuZWwgcGFuaWMuDQoNCkNPTkZJR19ISUJFUk5BVElPTj15DQpDT05GSUdf
UE1fU1REX1BBUlRJVElPTj0iL2Rldi9tbWNibGswcDE2Ig0KDQoqKlN0ZXBzIHRvIFJlcHJvZHVj
ZToqKg0KMS4JU2V0IHByaW50ayB0byBsZXZlbCA4OiBgIGVjaG8gOCA+IC9wcm9jL3N5cy9rZXJu
ZWwvcHJpbnRrYA0KMi4JU2V0IHVwIHRoZSBzd2FwIHBhcnRpdGlvbjogYCBta3N3YXAgL2Rldi9t
bWNibGswcDE2YA0KMy4JRW5hYmxlIHRoZSBzd2FwIHBhcnRpdGlvbjogYCBzd2Fwb24gLXAgLTMg
L2Rldi9tbWNibGswcDE2YA0KNC4JQ29uZmlndXJlIGhpYmVybmF0aW9uIHJlc3VtaW5nIHNldHRp
bmdzOiBgIGVjaG8gIi9kZXYvbW1jYmxrMHAxNiIgPiAvc3lzL3Bvd2VyL3Jlc3VtZWANCjUuCUNv
bmZpZ3VyZSBoaWJlcm5hdGlvbiBtb2RlOmAgZWNobyByZWJvb3QgPiAvc3lzL3Bvd2VyL2Rpc2tg
DQo2LglQZXJmb3JtIHRoZSBvcGVyYXRpb246IGAgZWNobyBkaXNrID4gL3N5cy9wb3dlci9zdGF0
ZWANCjcuCU9ic2VydmUgdGhlIGtlcm5lbCBwYW5pYw0KDQoNCioqRXhwZWN0ZWQgQmVoYXZpb3I6
KioNClRoZSBvcGVyYXRpb24gc2hvdWxkIGNvbXBsZXRlIHN1Y2Nlc3NmdWxseSB3aXRob3V0IGNh
dXNpbmcgYSBrZXJuZWwgcGFuaWMuDQoNCioqQWN0dWFsIEJlaGF2aW9yOioqDQpUaGUgc3lzdGVt
IGNyYXNoZXMgd2l0aCBhIGtlcm5lbCBwYW5pYy4NCg0KKipFbnZpcm9ubWVudDoqKg0KLSBLZXJu
ZWwgdmVyc2lvbjogNi4xLjI1DQotIERpc3RyaWJ1dGlvbjogWW9jdG8gNC4wIDMyYml0L0tlcm5l
bCA2LjEuMjUgMzJiaXQNCi0gSGFyZHdhcmU6IEFybSBDb3J0ZXggQTU1LCAxR0IgUkFNDQoNCioq
TG9nczoqKg0KYGBgDQpbICAgODIuMDc1MTIzXSBQTTogaGliZXJuYXRpb246IENyZWF0aW5nIGlt
YWdlOg0KWyAgIDgyLjA3NTEyM10gUE06IGhpYmVybmF0aW9uOiBOZWVkIHRvIGNvcHkgNTkyMzkg
cGFnZXMNClsgICA4Mi4wNzUxMjNdIDg8LS0tIGN1dCBoZXJlIC0tLQ0KWyAgIDgyLjA3NTEyM10g
VW5hYmxlIHRvIGhhbmRsZSBrZXJuZWwgcGFnaW5nIHJlcXVlc3QgYXQgdmlydHVhbCBhZGRyZXNz
IGMyZmMwMDAwDQpbICAgODIuMDc1MTIzXSBbYzJmYzAwMDBdICpwZ2Q9NDJkZmY4MDEsICpwdGU9
MDAwMDAwMDAsICpwcHRlPTAwMDAwMDAwDQpbICAgODIuMDc1MTIzXSBJbnRlcm5hbCBlcnJvcjog
T29wczogNyBbIzFdIFBSRUVNUFQgU01QIEFSTQ0KWyAgIDgyLjA3NTEyM10gbnVtX2RpZS0xLCBs
YXN0X3N0ZXAtMA0KWyAgIDgyLjA3NTEyM10gDQpbICAgODIuMDc1MTIzXSBLZXJuZWwgT2Zmc2V0
OiBkaXNhYmxlZA0KWyAgIDgyLjA3NTEyM10gUEMgaXMgYXQgc2FmZV9jb3B5X3BhZ2UrMHgyMC8w
eDM0DQpbICAgODIuMDc1MTIzXSBMUiBpcyBhdCBzYWZlX2NvcHlfcGFnZSsweDE4LzB4MzQNClsg
ICA4Mi4wNzUxMjNdIHBjIDogWzxjMGM5N2U1OD5dICAgIGxyIDogWzxjMGM5N2U1MD5dICAgIHBz
cjogODAwMDAxZDMNClsgICA4Mi4wNzUxMjNdIHNwIDogYzFiNjNmOTAgIGlwIDogMDAwMDAwMDIg
IGZwIDogZWQ3NmI3MDANClsgICA4Mi4wNzUxMjNdIHIxMDogMDAxODE2NjggIHI5IDogYzEzYWU1
ZjQgIHI4IDogYzEzYWU2MjANClsgICA4Mi4wNzUxMjNdIHI3IDogMDAwMGU3NjcgIHI2IDogYzEz
ZGM4NDAgIHI1IDogZWQ4ODE2NjggIHI0IDogY2FiNGEwMDANClsgICA4Mi4wNzUxMjNdIHIzIDog
Y2FiNDlmZmMgIHIyIDogYzJmYzEwMDAgIHIxIDogMzhlMzhlMzkgIHIwIDogYzJmYzAwMDANClsg
ICA4Mi4wNzUxMjNdIENQVTogMCBQSUQ6IDgxMSBDb21tOiBzaCBUYWludGVkOiBHICAgICAgICAg
ICBPICAgICAgIDYuMS4yNS1tYWlubGluZSAjMQ0KWyAgIDgyLjA3NTEyM10gSGFyZHdhcmUgbmFt
ZTogR2VuZXJpYyBEVCBiYXNlZCBzeXN0ZW0NClsgICA4Mi4wNzUxMjNdICB1bndpbmRfYmFja3Ry
YWNlIGZyb20gc2hvd19zdGFjaysweDE4LzB4MWMNClsgICA4Mi4wNzUxMjNdICBzaG93X3N0YWNr
IGZyb20gZHVtcF9zdGFja19sdmwrMHg0MC8weDRjDQpbICAgODIuMDc1MTIzXSAgZHVtcF9zdGFj
a19sdmwgZnJvbSBtcmR1bXBfY29tbW9uX2RpZSsweDMzNC8weDM3MA0KWyAgIDgyLjA3NTEyM10g
IG1yZHVtcF9jb21tb25fZGllIGZyb20gbm90aWZ5X2RpZSsweDhjLzB4YzQNClsgICA4Mi4wNzUx
MjNdICBub3RpZnlfZGllIGZyb20gZGllKzB4MTA4LzB4NGMwDQpbICAgODIuMDc1MTIzXSAgZGll
IGZyb20gZGllX2tlcm5lbF9mYXVsdCsweDZjLzB4N2MNClsgICA4Mi4wNzUxMjNdICBkaWVfa2Vy
bmVsX2ZhdWx0IGZyb20gZG9fcGFnZV9mYXVsdCsweDAvMHgzMjhgYGANCg0KUGxlYXNlIGxldCBt
ZSBrbm93IGlmIHlvdSBuZWVkIGFueSBhZGRpdGlvbmFsIGluZm9ybWF0aW9uIG9yIGlmIHRoZXJl
IGFyZSBhbnkgcGF0Y2hlcyBJIGNhbiB0ZXN0Lg0KDQpUaGFua3MsDQpKaWEtaGFvIEJhaQ0K

