Return-Path: <linux-kernel+bounces-304112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 198A5961A60
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 01:16:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43784B216D8
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 23:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CD581D45FE;
	Tue, 27 Aug 2024 23:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="eelFI9PI";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="i6LwAt3v";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="sKsbunlo"
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D5A680034;
	Tue, 27 Aug 2024 23:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724800574; cv=fail; b=JpVOyhTBzjC0KZZpME/1u03S+DoEpEfnxbxfj/9UyEVEmmbeSUh89Josqzbq33GmJDFwjL/TZfT37oHzqfJ0tEtm58kvOqtld6thv2nLkMCPstbaGxuk5Y/OtYGR+DIIyrJBrMUlHr3j1qCPAZCll+ellOW7oVhcShV6no70AwQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724800574; c=relaxed/simple;
	bh=6m5exqLAt+kIXS9mNpk/JAS5hmrCbjQPli8LU9kYtSU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=U4z8lPHvWBfZR4KO2s+UhVThpceQzfZoM3CotxCztd1R+d7qlm2YPX2227P8mTqLxtTW2kgQd/ZBScIRhK3j32A4w3o4uE5SwDDmickKQg5QGm3R5g7XTYMHxE2rUiVGD6LvOOY8lqwtC+b+7G6GwVpaOLCIr6Bi53n9FzcnDns=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=eelFI9PI; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=i6LwAt3v; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=sKsbunlo reason="signature verification failed"; arc=fail smtp.client-ip=148.163.158.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0297265.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47RLgwVH011867;
	Tue, 27 Aug 2024 16:16:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=6m5exqLAt+kIXS9mNpk/JAS5hmrCbjQPli8LU9kYtSU=; b=
	eelFI9PI46TUvPMVEMxwzk9hjaqc745yk7SWH7JNCB8O6bP6VQTHGMd9JllZ0b8J
	KqSt/QoGmeFj2fpNjXSsSow035Yno9kB3Q/XhowGNdbEyQp/jrcP9cS4wwpv2e7S
	Y10o0hjMITOmO5CBB9FfkSplrj9JBk7jSwMRyTVLse03n0wtVoUdjq9J6RliLbO3
	RiXzBUDqJVkyvt3MZ27FpC9TS1TdvC4uCqiZ3KIjM3LXxRbtcmldYBL0v65kqpgL
	kExJstJZ2W8Mwf/NEGeI6nFtp0hR36dfyRYljT5gGYhu9A0I30k7vw76i564D1wJ
	rGHTY0v7cHblCGchlfaVpQ==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 419py70den-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Aug 2024 16:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1724800560; bh=6m5exqLAt+kIXS9mNpk/JAS5hmrCbjQPli8LU9kYtSU=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=i6LwAt3vQKTnGCJyHBEWjiG8BRkw22/JSPQheRnFBfDVTC+R9hR8aX9U5QxLVR4fX
	 bn4cZAv0qI/PlkZoj9AJPaLtHFd07HvuQTMwf3kpQmCtoNaykTPOktZUMUIxBVA2BE
	 DDkWouujPObOYkVgyHh9LE2Tkpc+pEfc2j9To/ekQircHOJHz8b1a+pT3O2jV7M/YX
	 ltqv57TnmWOdIx8UqIg61/WqkOXe+qGzRPDdQ7n2HD7Ta/vIGlJq9HX1j2rxL9jM6t
	 0qZU4yOtOhWK3w0zQRRKDYQULKhdXa4emnFCP/9CNuLmW4vK4Nw4nm3/hzKxC+cFM0
	 tUxh5bjpzBppQ==
Received: from mailhost.synopsys.com (sv1-mailhost2.synopsys.com [10.205.2.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 95F8340407;
	Tue, 27 Aug 2024 23:16:00 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 586DAA006D;
	Tue, 27 Aug 2024 23:16:00 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=sKsbunlo;
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 919034044C;
	Tue, 27 Aug 2024 23:15:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cAZNxBVu00Lsh8rDfwTG+J6O5HG1t5Ffcs2Psl9nGSb+y+n5J8UQKQgenoGgbvGmtjGJnwC2BiAH9W6DKPC6H/YAy3xPTp6lN+wAJ2LeVOUNjYQ9wjGjnenKU19hdr58aUJ7iawu/WTznh33upS4hyBRe4aOdO68AIwXvss5aX7tJESCeKprZ0xT6U2J4gzQ8UnIIPDogOT3Q/CAAdbISlVcVjv1q4H4AQYN7QV1FyY4f+KX4zur3zaGCM0/97bnLVPdNcGb7+jJCkLdS/hvRRsmMH05UcBZO8+3FxTJHzkrhQkWNCpgtjjSf15THwHH8JzBanpXfTA5fYs/1jJkyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6m5exqLAt+kIXS9mNpk/JAS5hmrCbjQPli8LU9kYtSU=;
 b=vIJIxN5QxOrkJnqQFui0jTMks1zGFPFT70vo9LR7VubTTX+U0jcxsH2sudrnhvwqT81AGEEZ/7n3ch/zbWDy+QGmZSduTCbn7KOzXt1BIGsy0V3TvimNEprAjYylT0LndMV9qyuST4QyCR+/yZQHRtxckyUObz3oX0/sKFZbibaX4CUi/flznicNl66e2gdTBkzqEMqTTMk7u1+zIIJHvGWbSpoRkj2FgATMgtUo1cI8/cKDg8zi2fcZTiiQnVUeuIdhC+PkB2WaDorMeSBlX0aaKr1P8DlZIcjrwo4+QE0u+V+iIHm8c7ZBrk4z371Xe7cnEkWArLERnC6ekuoCfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6m5exqLAt+kIXS9mNpk/JAS5hmrCbjQPli8LU9kYtSU=;
 b=sKsbunlov4FpgoAhz+fJaYl+Y/ORDqHm7zMkV4o8IihQ4ApIkbl9lp1IZ+MJbM1yNTZQY0uSaOJbEXWNKMDmcLTKkvWMeis8sN2vSRIZyTX/WhBFFoUax8AfN2rd/PBzq6Z8oY+Q47j5dMNnuSReipOIAa+goHScvYKrzVlKqDw=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by SN7PR12MB6984.namprd12.prod.outlook.com (2603:10b6:806:260::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Tue, 27 Aug
 2024 23:15:56 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%5]) with mapi id 15.20.7897.021; Tue, 27 Aug 2024
 23:15:56 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Akash Kumar <quic_akakum@quicinc.com>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jing Leng <jleng@ambarella.com>, Felipe Balbi <balbi@kernel.org>,
        Jack Pham <quic_jackp@quicinc.com>,
        "kernel@quicinc.com" <kernel@quicinc.com>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Daniel Scally <dan.scally@ideasonboard.com>,
        Vijayavardhan Vennapusa <quic_vvreddy@quicinc.com>,
        Krishna Kurapati <quic_kriskura@quicinc.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: dwc3: gadget: Fix TX FIFO size for HS ISOC endpoints
Thread-Topic: [PATCH] usb: dwc3: gadget: Fix TX FIFO size for HS ISOC
 endpoints
Thread-Index: AQHa+EULTkB2OCYKX0iBD1wqItnyWbI7vZQA
Date: Tue, 27 Aug 2024 23:15:56 +0000
Message-ID: <20240827231552.7yokoe7jqdm3wduu@synopsys.com>
References: <20240827054956.28241-1-quic_akakum@quicinc.com>
In-Reply-To: <20240827054956.28241-1-quic_akakum@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|SN7PR12MB6984:EE_
x-ms-office365-filtering-correlation-id: 326047ea-4718-46f2-d6c5-08dcc6ee349a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?U3dkdk1kMzhRbEVoK29vTkcrMlhMelhYUjdCTGdFSVk0QVlzRE12Z2ZWUXdD?=
 =?utf-8?B?NmpXQzAxUkVtZURESTBZQzAwdXdUaE5KaEVIYVZERG5WUU1HZW5wK1Z3czdR?=
 =?utf-8?B?YWl6ajlNc291VFhvMUE4OXpuMVNqSncyVmFNeVcvU2kyVVhaU2U2ZGZLTDlS?=
 =?utf-8?B?M1Q5cUsvajRIWTFKQ21JK1ZUK2xBS28xUUFTV1daOGNYTCtPNEFGdHdMZ1FJ?=
 =?utf-8?B?dE9sWjQ5RWg1K3YrS3lDNFJCQ3R4RVB6WGpuc3R2dHRmWEQ1WkM0cnFBdzBI?=
 =?utf-8?B?L3E4czc4Z1JxemJYWkIxUEhYcy9KTHBPWFBiM3F2UVE2SVd5UzFhdm0zTzhI?=
 =?utf-8?B?ek9JL0pwR0FDVjhodWhMUUd4eFpsb3BRL3lOR1dMM1ZyOSt4MFdZUUlaS0hP?=
 =?utf-8?B?RkI0SVFEM2hkMjA4K1JYaUdtZG9iZUJ6NEYySWpFRzU2bzRXOUZlUEdxa3dr?=
 =?utf-8?B?cXYxclYvbU5wWmhYM3VmK0dHTWxxN1BFV0JOWWVLa0R6SnBPNHlWQmU1Q3R5?=
 =?utf-8?B?eHFtRENpcCtneWJUSksxMWRzYkUzZ0RDd0ozSjlpNHpMV1cvbXlNL3RRbXcw?=
 =?utf-8?B?VmsvenQ3UzJYanc0NFVRSDg4SW84OWVaT1BEZXFhTmx1WDJiSld3UmdZSVF1?=
 =?utf-8?B?VWJNU3hUL3JhaFhTVDVIUU1vZGZBQ0RvTjVkeFhjMkRXb0ZQWEdKNlhtVmRC?=
 =?utf-8?B?VnJNYjlueU1UV2U4NU1vZGc5UlZiQTRCbDJkMWJwbnVjSzhmeGgvSjZyYUkv?=
 =?utf-8?B?QXU1a2ZkNk5mMTkva3cwNjFyRW0wdEwvNU9KZ0NZaHdUQTZ2VDBUcldsZkVS?=
 =?utf-8?B?aTRrMnN4a2JlTzEyYmEvRHlrb0t3NlUva05CQ3A4ZU5YMERxTllQK1BnbmpQ?=
 =?utf-8?B?RlFiOW9mSHE5U2gyZHBKZDFZMHhUa3BadG9VcWpXK3o5WG5RK04zb1c0cENW?=
 =?utf-8?B?MEdpeDRRVnc3Rm9YbmZjRWhNMU45Q3hNYVBQT0JzUEhXOUJZcFdvR0Uwa0hi?=
 =?utf-8?B?c2dPSzg4dnNRdzhBZDIzTVdiOTQwaE4yendOOFgxVkQ5ZTZLMnhHZUhCcWgz?=
 =?utf-8?B?MzhHL1paWG85ci9ZVXlzbVBHbE0vREM2VVRTMUZFQWxOVVVEL0JUdklPcEFs?=
 =?utf-8?B?RXc3WVd3RDVxLzhjWTFmMzlwNmFpc3ZZNldwL1lzM29XY3F3MmNTMjljdHl2?=
 =?utf-8?B?MVVybG1zdFpVOE1VbEU5ekdxWDV4cXdLb1d6THRaVXpEZkl0NkdoVVY5UXpR?=
 =?utf-8?B?emFsT3dGRytDT3RoNVVSdFZEejFTQmNvNVVhS3JtWUR1cFpVWjNvb0tJblEv?=
 =?utf-8?B?T3JCN3dJU2k1NEN2L2o5SW9OMUZyQ25lRlJvNXppekVSTDI4eG5ISjdEODFt?=
 =?utf-8?B?T1NtRmNkeVlpY2RkNUdCZWsvN1lLTlY4bG9KYk8yWG1QMDRXbyt2TVpZT1FX?=
 =?utf-8?B?aWhZQXluNUZFc25jR2N6R3JoMEE0T3RnR2ZtdXlIVW1MRnoxZFNXWE1mZlJm?=
 =?utf-8?B?VUF2dlJsckUyaTBVbXg5bU9mbXVubHRvb2FVUW5MM1ZBS3lMQlZCejJOL0V6?=
 =?utf-8?B?OUdaSXZKdnhmYnBCdm9tTWc2ZThjSWF1aTc5bjNicEk4ZnlQSnFiWjZRSmxC?=
 =?utf-8?B?NERQS0xCUVZ4MmZrUmtZTjBTSDZZb215MU1CZjNqbFR0eWx4Nm95cW9GNmlt?=
 =?utf-8?B?eXBQczRPQ096ZzArUnozdnhiR1d1SGJrOUVWSEg0b2JpY1l4ZGRNVU5KbFg4?=
 =?utf-8?B?ZHB4VGdROTI1YURXUXpuc1RrU0c4UFRYMnN2M085WG5TL0FMTWNsNWxydGcw?=
 =?utf-8?B?eEFzdmhDREZjOEtSZDBqdUVNclQrM0M1TFJkL0ZLZmR3SDZHWXZFeWsxSTFG?=
 =?utf-8?B?VzZBWFBqY2JsN0ZXam9NWkQyOE1ONlJMMElEK0VBeEpZNUE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NHBsQnEwb0owdlZDVnpZQmVzdUV0M29mVlhML3JleXdiMjNaQWpEdjVweU5N?=
 =?utf-8?B?QVpSSkRuM2JxTnIxa0VXc0dkV2xjckZQOXJJbENZWldpelRMemNOVTRHendt?=
 =?utf-8?B?QmFZRTF0d1h5ems2bWE5SktVSUZpL1BnNWNCNzM4NmRvOTlza29wSUpoeFJN?=
 =?utf-8?B?SnZSLzZlcE5nM1Y5U0p2cTFsaWI4RUNMQ0hpclJud3RjWTJHVkw3QkFlY2pp?=
 =?utf-8?B?WFVGSWxlZnk0VnJjK0laR1hmRjdYdVhoNDc2TmRsTnZDdzc2Vk1lUGRzUFlu?=
 =?utf-8?B?dE5iZFZ1STB4K2YwSVp1RlVYMmNmYk02K0dTOWhLYmRQUVpvOUs0Yk5hTFZI?=
 =?utf-8?B?NVBxRk45MUlxUytpRWJOVkZuRlVub3dGM1l1Y01UWHFVOUxGUkY4L1Raa3BM?=
 =?utf-8?B?eFl0amlrSncrRTc1Y1FQM0tnU3U0ai9NaEVEUlF1aU1MT1hvSnZUNDRjdjN2?=
 =?utf-8?B?TThNS0VCK1c0djdjUEViYXgyQUVsbkJoYlphcEZCd2lvTlQrcEU3alV5aVlX?=
 =?utf-8?B?dlpHV0VtU3RBdGhwcjEvZ3o1SVA5Rmp2UkE3Qmg2aTlWcXpwbDl4Zi9sTnhl?=
 =?utf-8?B?ang2VThYYUdpcnBXbWtneTZMSDlOZE1mVUJaQWsvVnNyYzFVbTYrekdVeEtC?=
 =?utf-8?B?VitBaWlpMTNlNXdydU0vK0wzR0hxWTJzL3QweWlraEZpb0gyUWx4c3R4UFVt?=
 =?utf-8?B?TG9CcUFpYk1PZ253a1gxOFV0RHY3NTI4V1gzaE1jRFgzVTMxbnZCcEhkSXUv?=
 =?utf-8?B?Y0szaHdJRlpXaDFzbjBoTElzU0YwL0FaL041QjcxUGJuVkhmcHp2aUFuc3po?=
 =?utf-8?B?QW54SkhFdXVJeDNZWlJ4aVlJWUxPRHRIbmJFUTNBRWtsUU9pcjNJMjI0bGVK?=
 =?utf-8?B?UG9wNFMyZ3ZZMkpOc1JqZm93MkU0Q1VPR2xXQkhlbnBJRzJJMERDMkJyVjMv?=
 =?utf-8?B?UjdjRXRWckQ0d1JZZHBkL0E5MTREdk9XNTlCa1ZDVWRmaldTQVJ2R3FRT2Nr?=
 =?utf-8?B?eEFaUGt3V1RITGFrSUUvUGFpQms3SXE0ZTRHNVpJTEVva3ZCYUwydTBwdlZ4?=
 =?utf-8?B?S0RvdDZEQmduQlF2QWFxNGFrQ0VJdzd6a2laVGJ5UEFOMHJnK2dGT3NKeTNQ?=
 =?utf-8?B?M2RiYkZMeHFVUlkzbm5CaVo2L3JlUnJQdnlNTkdvT3R6YTZvYktSTGFaRkFy?=
 =?utf-8?B?MVBFZ1ZiQnNORDVoNTNIMXJBOERIMnNjaTZUMUZXODVsc2xRWkJ4MExHVThs?=
 =?utf-8?B?Y1JISVJzbDcxUVU4MWVOOG5JSDV0U29KdkluamxiS0krVVRNQmJ5QmJpOEZC?=
 =?utf-8?B?MUFIVG1sT0FHaFhjRmtRV1NKMTlIZzRWY2FWR2JRN3grZnFMd0wrSjNOL0lo?=
 =?utf-8?B?TzhBVS9saUdBU1M2YTNuZGkxOFQwUnNCUGZYQ2pmcEcrcGM1NXcyMkM0dHho?=
 =?utf-8?B?amQ1ZkJicWt2cy95UTYyTFlZUTJJZzFrQWIvYXppcnhkaGhrSzNkTFpnbDJa?=
 =?utf-8?B?cmVSYVNQYU5xNjNmakpVZ3kvTEFTMVMzK09ONHR3ZG1tWWZwZjNIbDZXdWox?=
 =?utf-8?B?SUdTVlZSUjllYmY1RnpBN1d5ZG9mZHdmUkg2MmNwOTZ4cmR5aWVmSWpnRU5K?=
 =?utf-8?B?cURoR2ozajlrOFlUUnFVck44UG5IVFhweFpITXdLMUpKbGd1U1ZlbFFlcEtN?=
 =?utf-8?B?TXB6MldRbURRU25zWUxrTThYdktwRU5kYVZZdGMrNTAvdGVGVml6ZHBXYTRn?=
 =?utf-8?B?dTBOMFhnaG9taktTem1OeWR3NUlHV0NyendzT0xraDdyanVuRmxZb1BiL2NX?=
 =?utf-8?B?SXBuR0hyNlRMOWJrZUowbHh2dUtHVEdGWUNlUzdDNDBGbWlSaWsxU3dRRlNF?=
 =?utf-8?B?d2dNSUFSY1ZEczI0cVM0TGZqbGd3b2M1RkF3VnBnUEJ4WU4yTSs0TXdjbzNG?=
 =?utf-8?B?ZW41S3owTG5qWU9BdStQOWI4anYzT2pwQkl0WFhCN05NeHE4REFSNVhzWTlE?=
 =?utf-8?B?dGI3Z2pyRlYveXkrZTJocFlPdE5nSkczY1JVN0JWWDdlUHBWUEp2QjlhUy8r?=
 =?utf-8?B?RVZlYXpnNTVhTCswQ2JMem13U3lLbDlad01YL3VBOHpOaDFuOXJTNTFnL0Yy?=
 =?utf-8?B?UkUwODA5L3grUDBQdnh0cURxNzh1MU8wbWEwYzJvc2t1R0pGcnF2L0NraHpK?=
 =?utf-8?B?bXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0BB98E7DC2C8A641947D3931AC67D0DC@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	v/GGssKxpjwNdyRnpc4kuBWsabfRAcxCzD1uZ1A0KS2UIwrmgYL10frwTXvS97PQcCazdgnl7BVqBgpXVzmuMx9inPUS1+KPcGms9u+OMj732V6umLh8tH4e0O0Z18VFA86QNBHiwbexjnYwTekDT+NyCpJw30BWnJFn5r9peGswJhRZu220DDlvfmuP//bmhr1+PyMXKV/CbAzHcC9MUnVPTH1zocRmHUqwhOVjDW0AQBPzoX61LLfonHhYHlrTgX8mu9oaHeSc+xZRChn2FrTpW+ZlZBfdAhV0+fBDYHEtDU8SLJlsEzAe7XyyaW4Bfke4t7NB2U/qnH1WfD6qQ48M8qpikRZKQYq7GwUPUALWnq39Qr0Lq5fgfb593bOtBYCh8gay15b0mzO3G3kUDyI5f6qqi1hho/fwN222r1gwzEw7pLSVwcx6KVWtLtFv4V6mdWKEQM3P3GBF41Z1zaZyty0pd7xRaC0gTDltTia/VXm4F5n/HSrzRGAWTJLJ5ps9dGPSFLE51NA2f/3pX2ZjMzmhHwPQQwQK/7Fo5DeNPJQ3Gky1ufQfQ097radDWn2iVHm+cvQA6chme1P8miUOp0/DwttTxjT/0/Q4Kdgf6zwIDu1nwGZOALZXV/O/ci+yOVk6eVR+r5Cio+/r2A==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 326047ea-4718-46f2-d6c5-08dcc6ee349a
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2024 23:15:56.6513
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0X7PVJmWwK87nGKyXX1Zrim1gik4qL/MMoZCFABubAywsq9RAWRe2hrnmEE/9qJkEgYVAO468edJs0SE+o09Sw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6984
X-Proofpoint-GUID: JUwYFYrHOdFdih6RJAQoUEwTy5jg53yr
X-Authority-Analysis: v=2.4 cv=QqQM3kyd c=1 sm=1 tr=0 ts=66ce5e32 cx=c_pps a=8EbXvwLXkpGsT4ql/pYRAw==:117 a=8EbXvwLXkpGsT4ql/pYRAw==:17 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=yoJbH4e0A30A:10 a=nEwiWwFL_bsA:10
 a=qPHU084jO2kA:10 a=COk6AnOGAAAA:8 a=bqDWiqtGh1Z0CUiEoNsA:9 a=QEXdDO2ut3YA:10 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: JUwYFYrHOdFdih6RJAQoUEwTy5jg53yr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-27_10,2024-08-27_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 impostorscore=0 suspectscore=0 mlxlogscore=921 mlxscore=0
 lowpriorityscore=0 clxscore=1011 phishscore=0 spamscore=0
 priorityscore=1501 bulkscore=0 malwarescore=0 adultscore=0 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2408270170

T24gVHVlLCBBdWcgMjcsIDIwMjQsIEFrYXNoIEt1bWFyIHdyb3RlOg0KPiBVc2UgMksgVFggRklG
TyBzaXplIGZvciBsb3ctcmVzb2x1dGlvbiBVVkMgY2FtZXJhcyB0byBzdXBwb3J0IHRoZQ0KPiBt
YXhpbXVtIHBvc3NpYmxlIFVWQyBpbnN0YW5jZXMuIFJlc3RyaWN0IDJLIFRYIEZJRk8gc2l6ZSBi
YXNlZCBvbg0KPiB0aGUgbWluaW11bSBtYXhidXJzdCByZXF1aXJlZCB0byBydW4gbG93LXJlc29s
dXRpb24gVVZDIGNhbWVyYXMuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBBa2FzaCBLdW1hciA8cXVp
Y19ha2FrdW1AcXVpY2luYy5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy91c2IvZHdjMy9nYWRnZXQu
YyB8IDQgKysrKw0KPiAgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMgYi9kcml2ZXJzL3VzYi9kd2MzL2dh
ZGdldC5jDQo+IGluZGV4IDg5ZmM2OTBmZGYzNC4uZjM0MmNjZGE2NzA1IDEwMDY0NA0KPiAtLS0g
YS9kcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jDQo+ICsrKyBiL2RyaXZlcnMvdXNiL2R3YzMvZ2Fk
Z2V0LmMNCj4gQEAgLTc4OCw2ICs3ODgsMTAgQEAgc3RhdGljIGludCBkd2MzX2dhZGdldF9yZXNp
emVfdHhfZmlmb3Moc3RydWN0IGR3YzNfZXAgKmRlcCkNCj4gIAkgICAgIHVzYl9lbmRwb2ludF94
ZmVyX2lzb2MoZGVwLT5lbmRwb2ludC5kZXNjKSkgJiYgRFdDM19JUF9JUyhEV0MzMSkpDQo+ICAJ
CW51bV9maWZvcyA9IGR3Yy0+dHhfZmlmb19yZXNpemVfbWF4X251bTsNCj4gIA0KPiArCWlmIChk
ZXAtPmVuZHBvaW50Lm1heGJ1cnN0IDw9IDEgJiYNCj4gKwkgICAgdXNiX2VuZHBvaW50X3hmZXJf
aXNvYyhkZXAtPmVuZHBvaW50LmRlc2MpKQ0KPiArCQludW1fZmlmb3MgPSAyOw0KPiArDQo+ICAJ
LyogRklGTyBzaXplIGZvciBhIHNpbmdsZSBidWZmZXIgKi8NCj4gIAlmaWZvID0gZHdjM19nYWRn
ZXRfY2FsY190eF9maWZvX3NpemUoZHdjLCAxKTsNCj4gIA0KPiAtLSANCj4gMi4xNy4xDQo+IA0K
DQpUaGVzZSBzZXR0aW5ncyBhcmUgc3RhcnRpbmcgdG8gZ2V0IHRvbyBzcGVjaWZpYyBmb3IgZWFj
aCBhcHBsaWNhdGlvbi4NCkNhbiB3ZSBmaW5kIGEgYmV0dGVyIGNhbGN1bGF0aW9uPw0KDQpQZXJo
YXBzIHNvbWV0aGluZyBsaWtlIHRoaXM/IChjb2RlIG5vdCB0ZXN0ZWQpDQoNCmRpZmYgLS1naXQg
YS9kcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jIGIvZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYw0K
aW5kZXggOWExODk3M2ViYzA1Li5kNTRiMDhmOTJhZWEgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL3Vz
Yi9kd2MzL2dhZGdldC5jDQorKysgYi9kcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jDQpAQCAtOTA4
LDE1ICs5MDgsMTAgQEAgc3RhdGljIGludCBkd2MzX2dhZGdldF9yZXNpemVfdHhfZmlmb3Moc3Ry
dWN0IGR3YzNfZXAgKmRlcCkNCiANCiAJcmFtMV9kZXB0aCA9IERXQzNfUkFNMV9ERVBUSChkd2Mt
Pmh3cGFyYW1zLmh3cGFyYW1zNyk7DQogDQotCWlmICgoZGVwLT5lbmRwb2ludC5tYXhidXJzdCA+
IDEgJiYNCi0JICAgICB1c2JfZW5kcG9pbnRfeGZlcl9idWxrKGRlcC0+ZW5kcG9pbnQuZGVzYykp
IHx8DQorCWlmICh1c2JfZW5kcG9pbnRfeGZlcl9idWxrKGRlcC0+ZW5kcG9pbnQuZGVzYykgfHwN
CiAJICAgIHVzYl9lbmRwb2ludF94ZmVyX2lzb2MoZGVwLT5lbmRwb2ludC5kZXNjKSkNCi0JCW51
bV9maWZvcyA9IDM7DQotDQotCWlmIChkZXAtPmVuZHBvaW50Lm1heGJ1cnN0ID4gNiAmJg0KLQkg
ICAgKHVzYl9lbmRwb2ludF94ZmVyX2J1bGsoZGVwLT5lbmRwb2ludC5kZXNjKSB8fA0KLQkgICAg
IHVzYl9lbmRwb2ludF94ZmVyX2lzb2MoZGVwLT5lbmRwb2ludC5kZXNjKSkgJiYgRFdDM19JUF9J
UyhEV0MzMSkpDQotCQludW1fZmlmb3MgPSBkd2MtPnR4X2ZpZm9fcmVzaXplX21heF9udW07DQor
CQludW1fZmlmb3MgPSBtaW5fdCh1bnNpZ25lZCBpbnQsIGRlcC0+ZW5kcG9pbnQubWF4YnVyc3Qg
KyAxLA0KKwkJCQkgIGR3Yy0+dHhfZmlmb19yZXNpemVfbWF4X251bSk7DQogDQogCS8qIEZJRk8g
c2l6ZSBmb3IgYSBzaW5nbGUgYnVmZmVyICovDQogCWZpZm8gPSBkd2MzX2dhZGdldF9jYWxjX3R4
X2ZpZm9fc2l6ZShkd2MsIDEpOw0KDQoNClRoYW5rcywNClRoaW5o

