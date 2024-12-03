Return-Path: <linux-kernel+bounces-428567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4CAB9E10AA
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 02:06:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 462E2B23A83
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 01:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B2E92FE33;
	Tue,  3 Dec 2024 01:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="U5gdnqvC";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="OO7QeNZj";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="kKurtmJd"
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F2B48C11;
	Tue,  3 Dec 2024 01:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733187993; cv=fail; b=cCF+Rhhw3p/jd4Qs1GmP25r4YWoSTU1HIeI0XQSIza6TKOxuz+EJOk4aYsuds6DjPdi+DeP4CCS7N5kWLJLVd4d9rsi3SjySOfVKu7GRKvN06qZEmPAGbULARNFoH3qJpVryEfvc4dhwtUiBDgjON3oOp8bc2grIumQW1Gs/6J0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733187993; c=relaxed/simple;
	bh=cGyxOY4vsUtEcUlBmWsyDMyfw3p8e/23HeRkGvR47Y8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FaQy9shcmBamKVmTfoZlFrGiFxxhFoD5EvD7c8RItSBMN7il6PEn6HbgiEfmR967hcBEY4w5tudRos1AGmQ/MXfucRtrkZ1SerGIsNoiEbKW0DS9zuyjYT0tapTG4c6oc2kWKKad/QUJKz5ks4zWvbad0EPeYC+TP8hXojwECb4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=U5gdnqvC; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=OO7QeNZj; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=kKurtmJd reason="signature verification failed"; arc=fail smtp.client-ip=148.163.156.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0297266.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B2JJnXd015899;
	Mon, 2 Dec 2024 17:06:27 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=cGyxOY4vsUtEcUlBmWsyDMyfw3p8e/23HeRkGvR47Y8=; b=
	U5gdnqvCJnsky3nBVE3ADdyn3eNJ/CP1aIRcdnQSwVOMUniiJYc0IDLqBin892Kf
	Rl5KzvEmpII25ChKy1SKY5eGHcb9jqxkU+8f9tKvXkhBC20lyM0AssvAuZPEaF6t
	WTL5goFgYvG/8mDdff47i6VLG3FsDLxnhYO3X3qNQrAEgAGCRpqIsFTmkeA1rMrP
	RqAOzBpyl2AYUE9gCaoqG+5fS7VJ5q1XuS5hbs/k6MrxKqkReBGc3gW//pK7NHSo
	+SHVpPLc2IZgaRzNRX0PVIXpraIwdXv4PpWx2eDFcvX29zo0x/H6Cqbj9ojUt3Hh
	sHeyURh7KlIGR39JsgeuYQ==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 4382ub2n85-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Dec 2024 17:06:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1733187986; bh=cGyxOY4vsUtEcUlBmWsyDMyfw3p8e/23HeRkGvR47Y8=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=OO7QeNZjslMV5Q/KnZhutvU2LAilCSszFYsOW+GXnLZPRkFUKN1sqD2UR5+c7WwNU
	 m9qXTongX/DmwXlRy3twnJORFNsVjMIgV3A6mwB25Qgv3n2sJ82k/6H6IjWkFw0Mcr
	 Cp5NwD6XEDxUE3b1oqUNQnnfFIbBfrWNdk+drjAWdZ0Nf+Pe/dEnS7wmKsGICSI86j
	 c4BWgVVj/d4WLHhEhZeKCQIFv/79NQjF403Oa0s0Wx5ccNbn1ufqQUC0vXhFQkjZsT
	 tKmSLOafwKCUOW5goyqI8yb5SWir2IhceidHmbTGUZjgaK/nkhIWVxENf+wS6timA+
	 THjJ/9CPIYybg==
Received: from mailhost.synopsys.com (sv1-mailhost1.synopsys.com [10.205.2.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 18EEF40593;
	Tue,  3 Dec 2024 01:06:26 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (not verified))
	by mailhost.synopsys.com (Postfix) with ESMTPS id D457CA0076;
	Tue,  3 Dec 2024 01:06:25 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=kKurtmJd;
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 84CB7401EF;
	Tue,  3 Dec 2024 01:06:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pbjclCXBoRMyUVB+XyRRIUAJIj6VwrLcpKSopwuN7YTwm7M0MJmN9DdRmnPVXG5YEkY8iRsqiUNMZdFBVG1KAgfQ8+LDo04Cv8NpNv0hGJ+Ew4EVcDxmnDnu+Bfapqodt1E9BsMcisIozWnZVADwqVFkb4ne8iUMof96ZubW8rQvIuf6aSLSXPpMXoH48JjlsrmYlh3ipoQLB91klRcnMkUQ9TXxyhyNDdVyhdg0YLYETJodtKWQZJDMbHmWRwWnT4hMTHWXn5FclvZ/kc3bnT6sftnFSSU+0fMz6q2cgVhvC5dFXQLBQEq3eEVl2a+Ja6k057Ux67kCx8nzS3+W+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cGyxOY4vsUtEcUlBmWsyDMyfw3p8e/23HeRkGvR47Y8=;
 b=aJX9OyRECZrfpW3T+BNzJX2hP9NLFYPPFfV6pbAnqi8JvNS6TcsR0c26en0eEkAL8DQcKP3wkJhV7Aa6yvuJveLTanKbGfkoQmLHVzUiMS1kghTazv2nb7y2orj139XXadxLg6QeSB5HVsicI+rbz1pcsZXo2zW1fBq+6I/3eUS+lRAcepaHb5QfNkMyr9IhYJk4MEBa6Pro+NeTZo4KSwJqFYhAGnSyIsDAmAfNmHV4KXKHGwPC0X5xqvwrVpBWHEyptL1nGqrUGrdMrjZ/3EHc64RsiaGiRr9KVMaZ0GRclU9vsszITIVaKBgzn6upVwszlv9UoV72NuQKbLOQ6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cGyxOY4vsUtEcUlBmWsyDMyfw3p8e/23HeRkGvR47Y8=;
 b=kKurtmJdzsnCnJCob68HKaCAE+vps8C4pBegiWMtBOE0KBAUPDd6rJ+/UVeKiT09pGFvCUwowdcVDobxyAqTTWKgXRtye+CQwul+1muGDHbjmnSIgsCTgsvodfooc6wlm7GtkUc94UVpJsx3HM75Hi2qbsRX6aVDf/sQo2+cFqQ=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by PH8PR12MB6988.namprd12.prod.outlook.com (2603:10b6:510:1bf::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.16; Tue, 3 Dec
 2024 01:06:19 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%4]) with mapi id 15.20.8207.017; Tue, 3 Dec 2024
 01:06:19 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Faisal Hassan <quic_faisalh@quicinc.com>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: dwc3: core: Disable USB2 retry for DWC_usb31 1.80a
 and prior
Thread-Topic: [PATCH] usb: dwc3: core: Disable USB2 retry for DWC_usb31 1.80a
 and prior
Thread-Index: AQHbQoT5Qz3ILl8bf0auHqn9a2Hez7LTuhKA
Date: Tue, 3 Dec 2024 01:06:19 +0000
Message-ID: <20241203010617.tfpguvbnmbi2xmnh@synopsys.com>
References: <20241129173422.20063-1-quic_faisalh@quicinc.com>
In-Reply-To: <20241129173422.20063-1-quic_faisalh@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|PH8PR12MB6988:EE_
x-ms-office365-filtering-correlation-id: 0d146f8c-3038-4561-d5ad-08dd1336b214
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?MktESEs2ZHRxakRrL01pdGNqNGFEa1psU0xUdCs0YktKRmJBWkhCQXBIUWRM?=
 =?utf-8?B?SDdLbGdNV1pRVmlwZ01QS1QzV1FuMkRBR1g5T1NqTnlWNkNnbWs4TURZQjFv?=
 =?utf-8?B?L2xOUGZwNmF5ZVQ0cmVRdzhyVnUvb2MxRjJRUFMwUnMreXlMcDJ1SUdxdCty?=
 =?utf-8?B?cXFwYVlMWlZFQVRBNnQxTFBXaXVXSnNjOW1pUDh5djBqeW5WRGdadWpGWUcw?=
 =?utf-8?B?U0RnV1ZWbnNOL0pET0did1VRc2ZveDJOSlYxZm9tSHBJRCtBY0NNSUFTWVZ6?=
 =?utf-8?B?ZUUzVU1QaTJGOFJoTS94c2MrSjF6MTZneTgyRFJQZTZTRi9UYktIcG5DVmw1?=
 =?utf-8?B?SlhFbVBaODcvTys5ZWg5bk1uRVNGZXBsSmR0eXlGN3ZybGRQYUdEa1YrOGtW?=
 =?utf-8?B?dE10anJlWHR0ZHFYTFYrM2FwUmk4UUJHd0lUSllydkhMZmZlRzdKSjNrdEJ4?=
 =?utf-8?B?Ymp0OHJhZ2Z6QXZYaHpLUlc1aytBZ2hFc3p4S2lTSzl0NGw2dWhSQk80ZGJL?=
 =?utf-8?B?RC9RV1p3a3k3WXR6TmxSMEFoazl5dmwreGwweG9wcS9HTVc5d1EvQmthQ3lr?=
 =?utf-8?B?ajN1L05JaDBpVGRMRUpOMElIbTAwbktlRngzaVRiOFpKZVExT2JtakZHSlRu?=
 =?utf-8?B?VndmS1VZMDVJZXFWU0RUUHRRc0U5NDJrRkU3SWovTFJHdmJXVWZLWVNkM1lp?=
 =?utf-8?B?bm1MaFNibngzOFk0ZlZlM3N0YTdBbm9ZQXlPRWt0UGVxZ2lUdnQwV3RXeDJ3?=
 =?utf-8?B?QWs4d0hSYVBiSTFLRzROMXVucXZKRVVVZ3lkOTZvTW1KK3U3WjR5cUtyd014?=
 =?utf-8?B?YkxwNEVLdXpwTTVEb2hWWW8zUzhLdHZUY09vZ0JpYVdyZ3lyQmtLRE5MSG5z?=
 =?utf-8?B?cnE3R2craGFrV2J0dVJTMEVycHRDR25iNGFYMldSUmlVU3NObEhIdGxOSlEx?=
 =?utf-8?B?M29VVUdDekY1ZHgwU1QwQi94RlRsc1RnQ0FOanZCSXZaRlJOZ2g2bVBmSmtJ?=
 =?utf-8?B?VDlEZTJ1YnpBdlRDM3RUcFk2NlFXSGY0bEZYQjFtRkhmNWVNMnFGdzFSUDlK?=
 =?utf-8?B?ZVRYdXNWSklJQkYyWnU0dVZRdFRHWmErMFJxcUZyd2ZDM0VEQmdTQ1ZzVTNH?=
 =?utf-8?B?QS9BSHpwN1BVYUtSKzJLRW9Ddk5DL0szMlhqR3VCWklnaHJDZG9RcVVMS1Y4?=
 =?utf-8?B?ZHJ1c3BQUzJYck83d1lmWUIrMm10bzZYV29BaXpXSU4yeFN6Qyt4aE1na0oz?=
 =?utf-8?B?dTZzRXpVbHJOVDMzYzVPRGc0dENleWlmdzJ1YUVxN3lJMmhDdWZ3RjlXTS9z?=
 =?utf-8?B?SFhTQWxPcHJaSmVxcFVzWDVFUTJNeExLSXh1U1RpTXExUDZJVXk4NVVORzA4?=
 =?utf-8?B?UVBoZmpJMnNsRUhJcnpMeWd6d3FzSHNIWE9XRTRqck55aFFrNWNYWXY5Z1F6?=
 =?utf-8?B?cUpNTXl4dXdEWmlLTnBXeFZFdnFxNnJBbTI3MXZMSXBWSWNpKzVYcWlQcFlq?=
 =?utf-8?B?OGQ2bDBQeDVjQjNqSDlRTHJXTkc3MU8zUWcwMks4MUY0RVo5RnV5YVRJWDJS?=
 =?utf-8?B?ZGVQQXQ2QjJpVTg4VXlsS1MrWXVrSGFZU1lWa2pFRk1wUWNvT0plTVRka2F6?=
 =?utf-8?B?b0QxN05xa3NZOTE4VDNveStzU1cyUVFHZFp1d0k4MEJQcFFOeDhoZm1SL1RM?=
 =?utf-8?B?dE0vbzBMQm5vWDY3d3g0aVlienp4WmxRQmZBc29nTDVqeEUrTVozZG81d0Ji?=
 =?utf-8?B?L2NIWXdiaGd3Tk5Eb1kzbUhzVlRBSmJtY3ZxZjkzUUZoNENOSFFINFNZeTFV?=
 =?utf-8?B?aXBKMDFNNmxDb1ZNeUtUbTVLUDVwOThDSlIvcmw2Yk8ybUlEQXVsUWdRVWIy?=
 =?utf-8?B?T1A4dU1rOW15UkFXZTh6Y1FDWXFmV2tKbTJ5NkNNRVlwRHc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eDNNY0JEeUVuNGF5TDZldkR0ck5STndiZFJpMDBlK25TVmZYR0R0N3ZWUHVF?=
 =?utf-8?B?aDQ3aWdXVmIxZ1ZxWmtVbSsySzExTUVLR200L0RBcGJYK3BzcTdTcVY4SDdQ?=
 =?utf-8?B?bEE0dkpmbCtuK0kyYTJ6M0piV1gzckhOVzdNUnpOTE0rUGluTHdWd0FTOVNG?=
 =?utf-8?B?OXl0TEU2QkppY3A0c2FKb0NidmlkallnMDE1K1gxK0RJR3V4b3BIK0E1aDlr?=
 =?utf-8?B?QmRMaUYrd0s4WnRQY3JVSDFmRENqd1JOa0JOVkJHUjgxY2FJMDNXT2FXc2Fj?=
 =?utf-8?B?SDVtNFdBajkwU3hOeDc0UyszQWVVVFdjRTFXN3dYMVlQd1lmK2pSQXAvYmxE?=
 =?utf-8?B?blJVWHFOTDYxR2Q4elZKRGRaY0xPeEdnbWRobUxqbGhZWHh4dWhpUjhGaVRz?=
 =?utf-8?B?aUswWXVVZUFrYy9vcjBrWnYvYi9sb2RvcG1HUkRIQmN4a21hdVF3bEg4NlNm?=
 =?utf-8?B?SXEraEZ4TVRTRGxieCtCejBvTFRyRFZaZ3N0dFdwdTBvZnc0SEQvbmpzZ3Va?=
 =?utf-8?B?aVpMMjY4RFJFTnIyc2ZPZ0lWdk1KMG5TeldqbkQ2dGNicUxzaHJGYnQzSmFN?=
 =?utf-8?B?czh6MGMwMTFRZkxyTVZ5UHh1M2R2YndOYnF0Q0RGbVdLbVZxVm9INzNSd3VN?=
 =?utf-8?B?cEVKU3pXTHFFVStqcTY4dGM3TzQ3V0V4M0hFYnh3ZXdoM1NmVXdxQlU3YmVo?=
 =?utf-8?B?UU5SOUV0YU92OUxBKzUwNlRBSGgvemw0eGhIRlViSVE2bVA1ZGRaV05UdGdq?=
 =?utf-8?B?cXNHcytwRFZxVDExR2orOVN6THRWTDhZdjFJY2p1R1dLNmNoc1d0V2E3aXVT?=
 =?utf-8?B?dWNsMFpCeEtTSFM2aHpjMnhwdkpNc0pDYUoySE5OcWxOYmZTbDJ0NXJHY29R?=
 =?utf-8?B?RTI5Y3pDRGtSd0ppeEYzam5VZHVXa2lycGpuUjcrNlVPNzl3TTZHVTVUZmJP?=
 =?utf-8?B?eHRoa2V2Qnd0ZzFoWDFkNDU4STVzVC9UKzNqSDJSQi80NUVxVFd6Ump3bWMx?=
 =?utf-8?B?Z0tqbVZSVjVGMDhKQXJtV09EOEVlN3JKQW16cGFqSzh4YTBtRm5ETFcwcUd0?=
 =?utf-8?B?VFFMZVFSR05XcGEvZjFTY285TXhoRGNkc3FhaHNIdThWYng4LzJuRDUxYzRt?=
 =?utf-8?B?L3dXbXlTSGdIV2F2NFdBcVNoY3VLWVk5bmpWSzhkQVpQZkJsR2phbytHTTM0?=
 =?utf-8?B?L1BMMEl0bG9BL0xrL2hqVzg2ZmNNWWZWeG5WTHhZYi9sNnJzOXFuRnVXalpL?=
 =?utf-8?B?VDVWQTdyaXpWemg0ZVE4Z0NuMTdGME1VWkZQRVdKMzBPR203bFNpbk4rV0dP?=
 =?utf-8?B?VWxaU3dZY2QxMkxGNWNVVWh2UmFpWTFrMmxSNkpxZnkyd3ZYZWVjTnJIM3NI?=
 =?utf-8?B?ajhnNklLL3lFLzVQSUNuZjBOcTNxYU1OY0tOWlZTUHFYS2todTE3Y3F5Ny9E?=
 =?utf-8?B?dGNVVXJOWDR3NW5DRm5FaVU5dnl3OUJ3WktLZ3lid2R1N05lVG1ONnVKUmZk?=
 =?utf-8?B?NUdJSEcwTkRsTmZ3WTRDdUt5bWZNbTNFWjg1WWxZcXpuNlh0cHhTRGJNekk5?=
 =?utf-8?B?STluTEJhcThseDV0TXgyMVVVdHNUaWRFcXgxQUpkdU0xYUZjNDZYdnRZM0V4?=
 =?utf-8?B?MmVneTI0dlZBVms4QU1DaFl2b0cvcUtrNWNjaHB3a1F6MUVSazhPWVBJOWNq?=
 =?utf-8?B?bVVma3hkSHhKRWRXUk1tNmNZdWJWSDlDbFMvdmlhM0grSmNXeWpTUHV2dDJM?=
 =?utf-8?B?TkNDaGRWZUIwZkJXQTJpaGExYXY3ZHV1SGF1S2pWcS9QcXRKZG9tQjM0S2tq?=
 =?utf-8?B?RzRHdHNoMkxGS0liSTI3SWNRSCt0TWYxVmVzbkNwTGxmeU5oNGIwY202MGRa?=
 =?utf-8?B?OGdsTmtWSjdaVEJwS1h3YmFMLzVwdTJSaGJaTm5adEFDaXFnbTliYm9BaG16?=
 =?utf-8?B?TEE0TG80ejFLTTRuRTloRkMzWlU0Rzc2dDNlNFVaa0xCYVhET005N25pb1E3?=
 =?utf-8?B?Q0ZjamIzaVZlclNJcXlaSXpQbTN3d25zU3EzdHgxdjhzVEUxeXhCYWZ5eU8x?=
 =?utf-8?B?Vm9lQlhDeUdCa2JmcTFaNzRIMG51aTRHeVpLa1Z3NkliY00vMTMwa0xvTG9w?=
 =?utf-8?Q?OeBrwNCz5HrQR333eReBwTmDf?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A88D0E7A84B279479E30134E55DC9C20@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	7I1yHbwT7dGZQdO2ueb69ygkc8GFmZjCMT+/6qgliS9m+cMjJzqSsxDiGn9ojrN/1WVCSDFg19svqAfcFuvrYbLuPbgq+IXDhdiURAizDkIJJEX3vNApYwOiw/XqHDo80r6i7ukpVteZhOoCkWQjrvjmIgfx6C3nr746ULXqTEtOBj1lpfkc3k+TXG1d2r1WsuDQ8owv8SJ0hAotFiRZY715P240i5AetKAz4mmfw0nuBoPJTLBPkZwUTnNFPcdcs+LO0XdgWQ3JZ8bE4fDPa+wyxXcg1CKKvV6IkIvR05/d/b3hc1C+sHEx0ddjByow/ErKZDo18i49vJTTbyFLzwKD21jfKWYck6vEYfzuHEJsxf7ZEwMSyZ9LkePro3dqWTwspWHYvTnwExo7vxftF4LYIB1h6o+ERKsKr3QGT3QkvlEHH/2Fq2R/4e5gPlb0k/r4HVXGJ5+ixzBa77L8AhsX2zuPZI7pTBacPbOmW4gc3p4OP3mNKShoIv83wBIIIpD32RvvV3BVyVZTr5vHJonFn9C8l6R5+Cy+Ra2Z7idjVpNf6HzXuaBEzS0NZRyacn0FJcMzAuLIJglOIVbpFzxWLa01jB5LHKznAxzN5u9RnvIvH3V6T6fOhK0K2SdWmFzaMk9Hl0sLlvyb/IxB1g==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d146f8c-3038-4561-d5ad-08dd1336b214
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2024 01:06:19.2764
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NJOc5HjVnmGbZsNVEGrH4pnPoSpwg3jHAOZ5PK9e2kF4xPcmRs7YKIXG3TAcZvex8fOxbLVu8NSCTPrQAgE+BA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6988
X-Authority-Analysis: v=2.4 cv=St9q6OO0 c=1 sm=1 tr=0 ts=674e5992 cx=c_pps a=t4gDRyhI9k+KZ5gXRQysFQ==:117 a=t4gDRyhI9k+KZ5gXRQysFQ==:17 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RZcAm9yDv7YA:10 a=nEwiWwFL_bsA:10 a=qPHU084jO2kA:10 a=COk6AnOGAAAA:8 a=jIQo8A4GAAAA:8 a=Rsz0veTWlMn9DbIlCDIA:9 a=QEXdDO2ut3YA:10 a=TjNXssC_j7lpFel5tvFf:22 a=Lf5xNeLK5dgiOs8hzIjU:22
X-Proofpoint-ORIG-GUID: dLw9UFEciFqbtst3OcBh-HJV5cmQO5ze
X-Proofpoint-GUID: dLw9UFEciFqbtst3OcBh-HJV5cmQO5ze
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 phishscore=0 priorityscore=1501 impostorscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 clxscore=1011
 lowpriorityscore=0 suspectscore=0 adultscore=0 mlxscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2412030008

T24gRnJpLCBOb3YgMjksIDIwMjQsIEZhaXNhbCBIYXNzYW4gd3JvdGU6DQo+IFNUQVIgOTAwMTM0
NjU3MiBhZGRyZXNzZXMgYSBVU0IgMi4wIGVuZHBvaW50IGJsb2NraW5nIGlzc3VlIGluIGhvc3Qg
bW9kZQ0KPiBmb3IgY29udHJvbGxlciB2ZXJzaW9ucyBEV0NfdXNiMzEgMS43MGEgYW5kIDEuODBh
LiBUaGlzIGlzc3VlIGFmZmVjdHMNCj4gZGV2aWNlcyBvbiBib3RoIGhpZ2gtc3BlZWQgYW5kIGZ1
bGwtc3BlZWQgYnVzIGluc3RhbmNlcy4gV2hlbiBhbGwNCj4gZW5kcG9pbnQgY2FjaGVzIGFyZSBm
aWxsZWQgYW5kIGEgc2luZ2xlIGFjdGl2ZSBlbmRwb2ludCByZWNlaXZlcw0KPiBjb250aW51b3Vz
IE5BSyByZXNwb25zZXMsIGRhdGEgdHJhbnNmZXJzIHRvIG90aGVyIGVuZHBvaW50cyBtYXkgZ2V0
DQo+IGJsb2NrZWQuDQo+IA0KPiBUbyByZXNvbHZlIHRoaXMsIGZvciBjb250cm9sbGVyIHZlcnNp
b25zIERXQ191c2IzMSAxLjcwYSBhbmQgMS44MGEsIHRoZQ0KPiBHVUNUTDMgYml0WzE2XSAoVVNC
Mi4wIEludGVybmFsIFJldHJ5IERpc2FibGUpIGlzIHNldCB0byAxLiBUaGlzIGJpdA0KPiBkaXNh
YmxlcyB0aGUgVVNCMi4wIGludGVybmFsIHJldHJ5IGZlYXR1cmUgYW5kIGVuc3VyZXMgcHJvcGVy
IGV2aWN0aW9uDQo+IGhhbmRsaW5nIGluIHRoZSBob3N0IGNvbnRyb2xsZXIgZW5kcG9pbmQgY2Fj
aGUuIFRoZSBHVUNUTDNbMTZdIHJlZ2lzdGVyDQo+IGZ1bmN0aW9uIGlzIGF2YWlsYWJsZSBvbmx5
IGZyb20gRFdDX3VzYjMxIHZlcnNpb24gMS43MGEuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBGYWlz
YWwgSGFzc2FuIDxxdWljX2ZhaXNhbGhAcXVpY2luYy5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy91
c2IvZHdjMy9jb3JlLmMgfCAyMCArKysrKysrKysrKysrKysrKysrKw0KPiAgZHJpdmVycy91c2Iv
ZHdjMy9jb3JlLmggfCAgMSArDQo+ICAyIGZpbGVzIGNoYW5nZWQsIDIxIGluc2VydGlvbnMoKykN
Cj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuYyBiL2RyaXZlcnMvdXNi
L2R3YzMvY29yZS5jDQo+IGluZGV4IDk4MTE0YzI4MjdjMC4uYzVjMzYxMzRkZGQ5IDEwMDY0NA0K
PiAtLS0gYS9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuYw0KPiArKysgYi9kcml2ZXJzL3VzYi9kd2Mz
L2NvcmUuYw0KPiBAQCAtMTQ3NSw2ICsxNDc1LDI2IEBAIHN0YXRpYyBpbnQgZHdjM19jb3JlX2lu
aXQoc3RydWN0IGR3YzMgKmR3YykNCj4gIAkJZHdjM193cml0ZWwoZHdjLT5yZWdzLCBEV0MzX0xM
VUNUTCwgcmVnKTsNCj4gIAl9DQo+ICANCj4gKwkvKg0KPiArCSAqIFNUQVIgOTAwMTM0NjU3Mjog
VGhpcyBpc3N1ZSBhZmZlY3RzIERXQ191c2IzMSB2ZXJzaW9ucyAxLjgwYSBhbmQNCj4gKwkgKiBw
cmlvci4gV2hlbiBhbiBhY3RpdmUgZW5kcG9pbnQgbm90IGN1cnJlbnRseSBjYWNoZWQgaW4gdGhl
IGhvc3QNCj4gKwkgKiBjb250cm9sbGVyIGlzIGNob3NlbiB0byBiZSBjYWNoZWQgdG8gdGhlIHNh
bWUgaW5kZXggYXMgYW4gZW5kcG9pbnQNCj4gKwkgKiByZWNlaXZpbmcgTkFLcywgdGhlIGVuZHBv
aW50IHJlY2VpdmluZyBOQUtzIGVudGVycyBjb250aW51b3VzDQo+ICsJICogcmV0cnkgbW9kZS4g
VGhpcyBwcmV2ZW50cyBpdCBmcm9tIGJlaW5nIGV2aWN0ZWQgZnJvbSB0aGUgaG9zdA0KPiArCSAq
IGNvbnRyb2xsZXIgY2FjaGUsIGJsb2NraW5nIHRoZSBuZXcgZW5kcG9pbnQgZnJvbSBiZWluZyBj
YWNoZWQgYW5kDQo+ICsJICogc2VydmljZWQuDQo+ICsJICoNCj4gKwkgKiBUbyByZXNvbHZlIHRo
aXMsIGZvciBjb250cm9sbGVyIHZlcnNpb25zIDEuNzBhIGFuZCAxLjgwYSwgc2V0IHRoZQ0KPiAr
CSAqIEdVQ1RMMyBiaXRbMTZdIChVU0IyLjAgSW50ZXJuYWwgUmV0cnkgRGlzYWJsZSkgdG8gMS4g
VGhpcyBiaXQNCj4gKwkgKiBkaXNhYmxlcyB0aGUgVVNCMi4wIGludGVybmFsIHJldHJ5IGZlYXR1
cmUuIFRoZSBHVUNUTDNbMTZdIHJlZ2lzdGVyDQo+ICsJICogZnVuY3Rpb24gaXMgYXZhaWxhYmxl
IG9ubHkgZnJvbSB2ZXJzaW9uIDEuNzBhLg0KPiArCSAqLw0KPiArCWlmIChEV0MzX1ZFUl9JU19X
SVRISU4oRFdDMzEsIDE3MEEsIDE4MEEpKSB7DQo+ICsJCXJlZyA9IGR3YzNfcmVhZGwoZHdjLT5y
ZWdzLCBEV0MzX0dVQ1RMMyk7DQo+ICsJCXJlZyB8PSBEV0MzX0dVQ1RMM19VU0IyMF9SRVRSWV9E
SVNBQkxFOw0KPiArCQlkd2MzX3dyaXRlbChkd2MtPnJlZ3MsIERXQzNfR1VDVEwzLCByZWcpOw0K
PiArCX0NCj4gKw0KPiAgCXJldHVybiAwOw0KPiAgDQo+ICBlcnJfcG93ZXJfb2ZmX3BoeToNCj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5oIGIvZHJpdmVycy91c2IvZHdjMy9j
b3JlLmgNCj4gaW5kZXggZWFiODFkZmRjYzM1Li41NDE3MDU4YzU5NDMgMTAwNjQ0DQo+IC0tLSBh
L2RyaXZlcnMvdXNiL2R3YzMvY29yZS5oDQo+ICsrKyBiL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5o
DQo+IEBAIC00MjUsNiArNDI1LDcgQEANCj4gIA0KPiAgLyogR2xvYmFsIFVzZXIgQ29udHJvbCBS
ZWdpc3RlciAzICovDQo+ICAjZGVmaW5lIERXQzNfR1VDVEwzX1NQTElURElTQUJMRQkJQklUKDE0
KQ0KPiArI2RlZmluZSBEV0MzX0dVQ1RMM19VU0IyMF9SRVRSWV9ESVNBQkxFCQlCSVQoMTYpDQo+
ICANCj4gIC8qIERldmljZSBDb25maWd1cmF0aW9uIFJlZ2lzdGVyICovDQo+ICAjZGVmaW5lIERX
QzNfRENGR19OVU1MQU5FUyhuKQkoKChuKSAmIDB4MykgPDwgMzApIC8qIERXQ191c2IzMiBvbmx5
ICovDQo+IC0tIA0KPiAyLjE3LjENCj4gDQoNCkFja2VkLWJ5OiBUaGluaCBOZ3V5ZW4gPFRoaW5o
Lk5ndXllbkBzeW5vcHN5cy5jb20+DQoNClRoYW5rcywNClRoaW5o

