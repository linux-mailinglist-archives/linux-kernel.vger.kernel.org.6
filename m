Return-Path: <linux-kernel+bounces-416428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A63359D44AA
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 00:49:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A1C81F2243A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 23:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C71041C8767;
	Wed, 20 Nov 2024 23:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="LHacp10L";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="ZfxUDpG+";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="UeeOLjKN"
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D6631BC9ED;
	Wed, 20 Nov 2024 23:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732146540; cv=fail; b=D1GIyLXK+5eg+zWb/yf5Dq/h3UBzz0lFUvNlQT0cSl8xacvq1LqgW/nrkFQsDBzR2RkkP8Nr1yKkex5SsAUMv/TpVq41/k5lMKqemQ6FnjpUoq43LVe7zimkB+TE+uCQa8i5WehyAwFEMNLj0SqJCW9LOU2oORPycXZGthJeuKc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732146540; c=relaxed/simple;
	bh=JP6g0f3Ft4zp5vsLcUiqPvQXhsKHK4vU+dYQfd4nTbk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=chgrzdH814gG48yi7h7UNccZDlXDtkK/KcC5x/iz8wwmbgCea7BFqNqBwY9bPJS4lpCMlydk2R4ujxy4YVAj5fKBdjonSDF2pHsl8RNW1yNZAJgzHf65xhk++z+Ci5sNWJ/UGms+rH3HtuvurLgh5H3+U6jaFpzg4JcSZ3tysr0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=LHacp10L; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=ZfxUDpG+; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=UeeOLjKN reason="signature verification failed"; arc=fail smtp.client-ip=148.163.158.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0297265.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AKGHwHx026901;
	Wed, 20 Nov 2024 15:00:37 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=JP6g0f3Ft4zp5vsLcUiqPvQXhsKHK4vU+dYQfd4nTbk=; b=
	LHacp10LJUpCVPXyagtMzI7LpLe72WlJMZJJjEMWgL8G/W5JW2AGVwp8oSRMssu3
	oyZOUEzgkd9b1ZrM7Q7XbhNqQF+YynhdukiB2JtLKCcxMSkd5mG/nB729zYQBINv
	gs8vu1lHKQDvw9G785trZ1cw2NJX+W3ELmf9YJedj/1VjpY/ifu9G22hs2CQSzhl
	i2P3T/6z07bRCEvHkdfhN59ky5Ja52m8fCoOp2Hlrj2zoxfLamqvTZzw4Uy3AMTn
	f+lGCQpLFT4dBwItOoelU/HxDumQKBWUSsFO1cXg9ivhceG6WMv+GfDiiN2e4NIr
	oAkmWBeUP4T6ccrWoyyrVg==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 42xu6y5g5w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Nov 2024 15:00:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1732143635; bh=JP6g0f3Ft4zp5vsLcUiqPvQXhsKHK4vU+dYQfd4nTbk=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=ZfxUDpG+Q4D/St2WGzAb0A+DkZ7IGWYicCUYrsTC+ATubk70bcEKTc5j2FOHN4coY
	 evDZWWA17RyC4+yalSrVcmcr8fS2dXnW/W4IJunLL8bykpjOwDxlhHQnckXouTeYyd
	 G+MUi/iNjh+zX6sXS2IEcF7VKQd3fCTytcKPn1zA+omTJd5g9b8u5/mL/ImkAUAPo3
	 56oJndoTyL7f884sYHpj5p8jJTy8YJ4i+G04OV9XAD/4RhRkAKPSbJauOHpd1RvKDT
	 6o/crqDsWKdkna0UYlVJp5BQPfaWdaHuOdWI63iFLc0h+ZWJLqUbPGfgqFTRsvqQZI
	 C1L2JIhBIsg8g==
Received: from mailhost.synopsys.com (us03-mailhost2.synopsys.com [10.4.17.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id C440D40144;
	Wed, 20 Nov 2024 23:00:33 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (not verified))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 4506FA008F;
	Wed, 20 Nov 2024 23:00:32 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=UeeOLjKN;
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2048.outbound.protection.outlook.com [104.47.56.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 00EFD40112;
	Wed, 20 Nov 2024 23:00:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w9YLygThVGcYOGgRP8uIIjdAlsg/MwYWXk50v4xNpmWDVoaRqcU4dAnL8DOzkXoovZ+UcjEdVn6v3bap8oRUscKFhR4ASS6nRZAMFU5w2UNRYVbM/44oArAJqyKIqhmQnW0YWR1mK80scMFvyoFCz4pbOanYiR8fmKqW9q8MB1QH9E7VzDkSlqnH5dSzKPe4PbxJhz5alphTeIH+J9CZlMWrKggr+SlVSLCnlNE3SsqDxh9PSxPRcDYuy7N1rckv0vSIS6IBB2JEJUgVIh6emeMeE6TbORUwHltzLgyWcWwITF8d6sekRhAHyU/ox3ArYcYCaMF9h1x0PEK1FjsUug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JP6g0f3Ft4zp5vsLcUiqPvQXhsKHK4vU+dYQfd4nTbk=;
 b=SWt94whXqLwNemFPeXjuFz8p0CyckJbJ63zYTxDntNqdP0CVLhqoEPazhlrwU9jSkotsJh9enj2fQh6Cg9Y7DHqBqn1LDnr4s3Sp0x51tPziIzitoDrgqWIzfWvZCHBJjwb/hJO/llU0RjdoKKDxjqDXw0dPsfxW2id+V8LDD3KW9WL+z2S9lVbDdV80XfoSGyaWsQCM/QRVML/XTEBfYqmlZnzfFyL7W4MF02hhO/0EzCgi8leUSLFMntzf6RkbyMvhrUTIXiQk/PZycmqTsgyrKTPK7KrkI9opLaF0bDnNlOYjU425Np8m6K8V85DJHyMYgEAxIsZ2BQWHAtD+wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JP6g0f3Ft4zp5vsLcUiqPvQXhsKHK4vU+dYQfd4nTbk=;
 b=UeeOLjKNZqv3F5eJRtXL0iltNTWL6KrP6XNRtSTPE72m6vLJrbmkXx9oTag0FEiuvPKYDwCPJYcOLKGy1vw/KdPmEf9bwCw+AD/4Q+MqcYzGC8OrmP1z5w5cWbhDInCx/+pX6k2MY96lbkOKHUAjYvukjTe1ezqKZ/ZHrej83XM=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by CH3PR12MB7500.namprd12.prod.outlook.com (2603:10b6:610:148::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Wed, 20 Nov
 2024 23:00:27 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%4]) with mapi id 15.20.8182.013; Wed, 20 Nov 2024
 23:00:26 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Luis Felipe Hernandez <luis.hernandez093@gmail.com>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "rbm@suse.com" <rbm@suse.com>,
        "skhan@linuxfoundation.org" <skhan@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel-mentees@lists.linuxfoundation.org" <linux-kernel-mentees@lists.linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH v4] usb: dwc3: remove unused sg struct member
Thread-Topic: [PATCH v4] usb: dwc3: remove unused sg struct member
Thread-Index: AQHbO2Ngz1EJpIKD/EKg7hKCJ2IoDbLAyS6A
Date: Wed, 20 Nov 2024 23:00:26 +0000
Message-ID: <20241120230023.jb6s5yfyng3dlgpr@synopsys.com>
References: <20241120154604.51815-1-luis.hernandez093@gmail.com>
In-Reply-To: <20241120154604.51815-1-luis.hernandez093@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|CH3PR12MB7500:EE_
x-ms-office365-filtering-correlation-id: 18ffabd8-ffca-4787-8f6a-08dd09b71f2e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?NmN4TmJjZ0NWdVFNU3lLRHh5dC91YzczWnlkaVVJcGQza3RqckN3TVRESmRC?=
 =?utf-8?B?dE9qNGJBUHhPOS9MLzFrOHFLODdaOVd4L3pEeXQ1NHFjR3FES2VvN2FSVVM1?=
 =?utf-8?B?dUV6Z3BsTUJQTWFUeHZaYWp3U2N3UEVDN2VFYzNFbGZmRTZIcWE0dGkwanBv?=
 =?utf-8?B?b3QvMEVVV2huSnNmTGxEV2lVMkFsZmlqamZvV0RBUXFicUE5TjZkTGhRNnZw?=
 =?utf-8?B?RnpXZDRTT3F1dVRHb1hoS0RRMzdtNm51a1orZVVDdWwrUVpqRytkUzUxaEpT?=
 =?utf-8?B?WkUzVE1DOFdxYyt6ZHpJbzVBQTNKQTR1QlpyelcxclMzMDR4aEFXS3RtOG1o?=
 =?utf-8?B?TWVBdE9RSzJNVDlFR1NoYnAxT1FmN2dzUTZmNWJIbGlUdDlUdVg3MWp2Mk5t?=
 =?utf-8?B?V2pHUFIwVnI0Mms2K1VGMDlOdk84VE4rTmhBSmxuR0FDek9nSjZmb3lTbUZQ?=
 =?utf-8?B?NEtTa3lFSUhCZ3ZXN2tjMEJUVHM1Vis1KzRyVm9NbDJDZmRGbVNRbFRNK2tK?=
 =?utf-8?B?SFllcWdPUkRtYnJlMUR4VEZPd2tRbGYwMkl5Y1FtazZNME5DdXZweXo2UWVW?=
 =?utf-8?B?SkJlM2UvVC9mZk1tcnRHSWM4OUZNc0Z6M0ltcXVhcm01STdraDNRTElBQnpV?=
 =?utf-8?B?NUpteEdXbW1xU2NRS3Z5bGxTVm85MnFzOE1ZNy9sQkZ1aHN6c1NvSmtZUzgv?=
 =?utf-8?B?Q3o1bENhV3RQK1JmQU9ncmxaVUxGWitiaFVqZ0dRQU05QW4wcDd4MVZoUWo4?=
 =?utf-8?B?QmgvTzRxNStQSllGOFp0QStpMjdBUm8wcUNqZzkwS0tLaldScTR4L2ZuQTl1?=
 =?utf-8?B?VTZJaGlmK1p2RUdacXhOaDBBd3d1ZjcvODFjZ3M2c3k4RFNReFZ5WGkyTU1V?=
 =?utf-8?B?bjZKZVJhS0h2Z1pRTVpSY1dWbXlGSXRENytHUUFaa2xlbEw0eHlkR1FxTzd3?=
 =?utf-8?B?TEpsVzJyUW41TDFHU1QrMS9xNForVHpwMS9HcER1M0ZRak1SeDdIQVBIWTcx?=
 =?utf-8?B?bHhmc0ZuTnVUbm81ZWgraWw1cmtGQTRGam1WWFpaZFBxSklWT1Z0MGZUVWV4?=
 =?utf-8?B?T3Y5S2ttbXNDcCtzbnNuTEwyQXVNZGZ6L1RERm5PS045ZmFvMTR3bzV6NUpj?=
 =?utf-8?B?L0xaamtwRkhHdDcwWXNOZnFxOXN4Tlo0eENWZ01aS0lvK283bk0vTUlMSFpy?=
 =?utf-8?B?Ty9oRU0rMk5WK1pLODFFUjlTVjBjTDNISUhCbmx0Nm9hU05iWEpNank0ekJL?=
 =?utf-8?B?VFF6dDcrUm1yMFFlSjg4UXVqdHh6SzMzNTVxa2lpVTE1QS9DM080aUt2TFVn?=
 =?utf-8?B?ditxL25KNzNJOTRhOE9oVG11d3dveVUrYmtoWXg2bHJLQ0ZBVHdEdVk3azFI?=
 =?utf-8?B?djNqR1JEdEw3ZFFrRUNhT2ZoYnU3VnpOWHJXMnJLMmZ0aVpoQzRSc1JZUWZi?=
 =?utf-8?B?VU5zcDRuaGJkMzBtcWpNQVpsbnRoUUhjMHA3d0QwenRYSXNyUExHUkxkVFF0?=
 =?utf-8?B?WHYvSk1kNkpRSFJrbzlnQVRNMGs0Zks0WG5ZMm5CVk85NVhqL1o4U3Y4a3d0?=
 =?utf-8?B?eTFaWlMvTHlyQW41QnE2S1Y1cUZadXBQVWM5RGRxRDBRYVowVUd3KzZDcGhX?=
 =?utf-8?B?aC8ybmF5NUp5OFdPVDNXRnJaMGRKZXRBVkhIYjk2RlZEN2RsbmdaUkpTQTMy?=
 =?utf-8?B?bEJYakRpeU1pTnR3YmtnR3JSSU84YmZqcGVCcUdyRHRuQVFTNEREbDY3THh2?=
 =?utf-8?Q?BsGRlfSjrrokgv6+qf+f/4fDN+P7r8NeCl0aDUz?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MnZxZEw4VG9ZM01GdEFpMGNKYlhaVXA5K0JZWU1sTUE0R05FalJVUXlhWC8r?=
 =?utf-8?B?cW0zcTdBeE9BOWRxbW40L0V5TlEwdzlqYW9PUDN6MFkvU1hobVBna3BZZ0Y2?=
 =?utf-8?B?UkJXY1NEeHVjQ3hrK3ZMMUZNTmNRTDhUOERUYXk1ZmU2NlhHWUVqMzRsWW8x?=
 =?utf-8?B?aU1NNjUrSkg0SEh3bU9MNDMxbVpVcHVoT2VER1kzSmpDRUV5a1BSa0NtL2hu?=
 =?utf-8?B?M1cyZm5QL0djRnB6MHk1VytpZnRmTStaUCtTdXBvcWNPS0VUZGtSMkpJdlZu?=
 =?utf-8?B?NVh6a1VVYkJ1djRuN20wWlVJblNnMnNMV3BLVVJUOGRDK1B2RFdDMlZhdExh?=
 =?utf-8?B?S1JEMWtGQlFHTkE4UWttUzRLdm5ZdzVGZWZKRzhoVDh6ai94Nk4xcCtwS2Vi?=
 =?utf-8?B?ZDkwVXk3S1gzYk1UNXZNeVpmcUE1R1lVRUpOS3d1MG9KRVFpd1RST0d4STd1?=
 =?utf-8?B?NkJSa1dhNU54UFFWT0tXYnlzTjRoK0Zjb2trNGt2Z2F1NkQ5eHgzVitKdXd3?=
 =?utf-8?B?RkM5dTJ5ZEV2MWFEaVQvM2x0QU5IeDVDVjBPSFhGRWZ0ZW5hcTI3dDlLcTNU?=
 =?utf-8?B?NnluU3BWVXc0U0pMV3k3QklOT1djSUZSeVdrdnYxNnpWd0NVYW9rc0lwTTFh?=
 =?utf-8?B?bDZXemtPTGdGUVoyTzNlSEg3am9BWjJGSUZiVXp3Rmk4L0dyUDV6ZUh5K2pF?=
 =?utf-8?B?Y3pIclcrRDVlQU1pOVc2aTUzVHZoSmhrUWM2SXJBV3VLQ0xaRnREb1dlMi8z?=
 =?utf-8?B?ank5QmdKbGNqdE5RMm1EMjQyQmtzMGo0elphcFNLR0FqVHUrRUMrc014SGNK?=
 =?utf-8?B?YTZSL1oxbWZxUjV1ZDNGQTdMK3BzOGhYaDArTUxTd2dqSW1BL25ybkR3ZXRq?=
 =?utf-8?B?c0Z5S2F2QlR3Ym0yeE9mM093YWtEMWQ5SjhFeEVHdGZNTDA3VEcvSzlubjV4?=
 =?utf-8?B?UFdOV0dFNDMvMVc0allSUUQ1NGd5M0cvMUNJNVlwNzJwcUM0R1BlWWtlbUlJ?=
 =?utf-8?B?ekpaNUNCK2hBM29kUU5wclV2YWo2cG1IRzBqL3lzZ2NSbjZVVHgvbjV1WnNN?=
 =?utf-8?B?b1U4b09pVFJwZVZKcngrZTNQSG9rNkpTN2p1YU96VGVNV0tBYUdnQ0NHUXV3?=
 =?utf-8?B?T1YxWmlkUkNsOW90dUE0aWdaeUJTZmM2bFpXR2JpMGM5WkkzeUczRnd2bmZF?=
 =?utf-8?B?WXRxK3dYVUFkcVo3WTcvb2U3bUdpenJ5OXZCUGlTSHJORGpJUW4yTk9GYmRi?=
 =?utf-8?B?YXdNVnozZ1ZlQlUvOU51bWlXQngvKzFnMnBYR1V3Ny8vbXdOZDZOY3E0YW9P?=
 =?utf-8?B?U001b0Y1RnRibkx2NWdJNVpuYzZoQ1lrbUlDWjNFTDlHNlR0Zm9hUDNZdmJ0?=
 =?utf-8?B?VTNzVDBXUmFVaUlwN2JnZnkxY2t6dnZHdUx1bmR5dEI3R3FadThNa0UzdEE0?=
 =?utf-8?B?eDZJNElOemJ5TE9GOWl6bHNuMVpHSnl2NW1icnNXVEhyWEREVTdXSjBIRVdM?=
 =?utf-8?B?dGdBbGNkekt2bE5RMlZlQkVOVDgvRWZMQnFWVmFWbCtOK0hhMHJOZGp4SjM2?=
 =?utf-8?B?bURmb0NHWUJlaDBaaG1SZ0J3WWtYSTdDY0FzbEJXb0RPSzNEQzVMaWJ2UEw1?=
 =?utf-8?B?aGFwQW1UdEgvWWJxaDYzVVlISHdxbkJvZEdnQWE5UWFMcFdWZS9mVEpmV1Ju?=
 =?utf-8?B?VVdtSFdObnN0L3Fla0ZYSUdzaXhPZk1ySWNmbTI5cTNqN3lDenFJMXVRTHk0?=
 =?utf-8?B?dDJIOGNXZklUaERES2doQjRBUDQvUkV6TDVIQVRBeGtLR1RvSjgxZW4vYTJz?=
 =?utf-8?B?TVhLWnVLU3VqVWxtaG11YS9oRDBGMzVWKzI5Z3FRTEVVL0R3aTQzV2RBTVp4?=
 =?utf-8?B?VS96czdsZWlUZXZHR3BrTWV1d1pweUU5MVRIQjNBU2NXbVdRV3NRb3lCMkNG?=
 =?utf-8?B?QUV6b2puVVE4ZUJsVCtNZ09WNnpYQ2NyeEFRaWVXTVI2bTY4TnF4SG56U3dz?=
 =?utf-8?B?RjRyb0RJMjdDZkRUdnlxaldRd0tjVk0rcWZUK3RzNytNTU1zeG5XT0Y1d3Fz?=
 =?utf-8?B?VFRCTWwrd29MZWdPWVNNMzdWQWI5VHVlb01UK0xOUVdLQUhma0h4RjIxSEpH?=
 =?utf-8?Q?pLLpaKAJH7zsy43l0teNVPKhb?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A80848FF11AB5641A47227FDA429C189@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	UUCF25r7NKquZCsrZ+ikvuZSnQyOR8ugLdxrD6DgsAfcBmppTWnVuWMsuBst2g8elef0HjtZjEqmsde+e/1WlkmpjwqnK0pGoPx1/0LZfg0B/FOFihvxQQn8vGyUryIpDOVuEtFhgKYeeB9ZaR/B22+rdg7VrfOpVjns254PltZwFYr3kB0HdKLvk4j4OtI4/uJpPgyG395LwKn4Qxn7lG+Zg4vAZS/IiCMD25s+QRmmnmDOS073nQqa1meS2h9630pQR6557X7tMMCzZLsDq9VTEqSCNARHXpxfRYmFy+Krc5Gy8s6R4Fw80SHoH/N81oPqDGLmXGL6Zrw9517zTLeIx/XrT+SaJEog6djUH5CLUkCEvby6ZTHksPcm23f5efoHt4QsIQD+bOmDRf9+0ve2Ev4IobFS/iFCoaYMnG4oEkJ4ySa4jkOWVW2nuOnIB2B9HwMOoPARcyrASUm/p0VwCl9THBmxRffeflB91OrlxiWBSpk+afwVEbMeq5yfy9ImyyFrbeE03G1QzNL56sWp5dJl46mbO7Th4jYfIk6ssHnny67/uqAzJGioivodxYAxHGizZl6nDnRlIi5kZzd3PWe6xoI/ccvggPGx7eI4yhnqJpDIoT7WTVzV4ZZccdgVAl6IxR9LGR9WGWO32g==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18ffabd8-ffca-4787-8f6a-08dd09b71f2e
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2024 23:00:26.3051
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FbTj7ymjVTxVIskBXgdzKt/OgJ9tFhJwJ0HX0D8n0wCyEpm0gkYsmld/IMnQYMbklgtlShvd3711GBLXFET4bQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7500
X-Proofpoint-ORIG-GUID: cFTywf4CK8pvCN6k0KJOseOYoj_ZHCi3
X-Proofpoint-GUID: cFTywf4CK8pvCN6k0KJOseOYoj_ZHCi3
X-Authority-Analysis: v=2.4 cv=JI5psNKb c=1 sm=1 tr=0 ts=673e6a14 cx=c_pps a=t4gDRyhI9k+KZ5gXRQysFQ==:117 a=t4gDRyhI9k+KZ5gXRQysFQ==:17 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VlfZXiiP6vEA:10 a=nEwiWwFL_bsA:10 a=qPHU084jO2kA:10 a=VwQbUJbxAAAA:8 a=rOUgymgbAAAA:8 a=jIQo8A4GAAAA:8 a=iox4zFpeAAAA:8 a=pGLkceISAAAA:8 a=6zXYmIRHL7c-Pv1aY8gA:9 a=QEXdDO2ut3YA:10 a=MP9ZtiD8KjrkvI0BhSjB:22 a=Lf5xNeLK5dgiOs8hzIjU:22
 a=WzC6qhA0u3u7Ye7llzcV:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 adultscore=0 mlxlogscore=915 malwarescore=0 suspectscore=0 clxscore=1011
 priorityscore=1501 mlxscore=0 bulkscore=0 phishscore=0 impostorscore=0
 spamscore=0 lowpriorityscore=0 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2411200162

T24gV2VkLCBOb3YgMjAsIDIwMjQsIEx1aXMgRmVsaXBlIEhlcm5hbmRleiB3cm90ZToNCj4gVGhl
IHNnIChzY2F0dGVyLWdhdGhlciBsaXN0IHBvaW50ZXIpIG1lbWJlciBvZiB0aGUgZHdjM19yZXF1
ZXN0IHN0cnVjdA0KPiBpcyBubyBsb25nZXIgdXNlZCBhbmQgc2hvdWxkIGJlIHJlbW92ZWQuIFRo
aXMgcGF0Y2ggZWxpbWluYXRlcyB0aGUgdW51c2VkDQo+IG1lbWJlciwgY2xlYW5pbmcgdXAgdGhl
IHN0cnVjdC4NCj4gDQo+IFRoaXMgY2hhbmdlIGltcHJvdmVzIGNvZGUgY2xhcml0eSBhbmQgYXZv
aWRzIG1haW50YWluaW5nIHVubmVjZXNzYXJ5IA0KPiBtZW1iZXJzIGluIHRoZSBzdHJ1Y3R1cmUu
DQo+IA0KPiBSZXZpZXdlZC1ieTogUmljYXJkbyBCLiBNYXJsaWVyZSA8cmJtQHN1c2UuY29tPg0K
PiBSZXBvcnRlZC1ieTogU3RlcGhlbiBSb3Rod2VsbCA8c2ZyQGNhbmIuYXV1Zy5vcmcuYXU+DQo+
IENsb3NlczogaHR0cHM6Ly91cmxkZWZlbnNlLmNvbS92My9fX2h0dHBzOi8vbG9yZS5rZXJuZWwu
b3JnL2FsbC8yMDI0MTExODE5NDAwNi43N2M3YjEyNkBjYW5iLmF1dWcub3JnLmF1L19fOyEhQTRG
MlI5R19wZyFlQmhqNTJRYWZfd0dabUs3NFNMSFN3MnVKbHdXZ3lIRTcwUUZWTzNhWDhGZ1pQeXlr
emRyaUhxUUdHODhsOUdhYnNuX2xYT1B6enVVVEVSR3hWT2IwZGdESmpFQU1mNCQgDQo+IFNpZ25l
ZC1vZmYtYnk6IEx1aXMgRmVsaXBlIEhlcm5hbmRleiA8bHVpcy5oZXJuYW5kZXowOTNAZ21haWwu
Y29tPg0KPiAtLS0NCj4gdjI6IHJlbW92ZSB1bnVzZWQgc2cgc3RydWN0IG1lbWJlciBhcyBwZXIg
cmV2aWV3WzFdDQo+IHYzOiANCj4gICAtIEFkZCByZXBvcnRlZC1ieSB0YWcgYXMgcGVyIHJldmll
dyBbMl0NCj4gICAtIENhcnJ5IG92ZXIgcmV2aWV3ZWQtYnkgdGFnIGZyb20gdjIgWzNdDQo+ICAg
LSBVcGRhdGUgY29tbWl0IHN1YmplY3QgdG8gcmVmbGVjdCBtYWludGFpbmVycw0KPiAgIC0gVXBk
YXRlIGNvbW1pdCBtZXNzYWdlIHRvIHJlZmxlY3QgYWN0dWFsIGNoYW5nZSBnYXRoZXJlZCBmcm9t
IA0KPiAgICAgVGhpbmggTmd1eWVuJ3MgZmVlZGJhY2sNCj4gDQo+IFsxXSBodHRwczovL3VybGRl
ZmVuc2UuY29tL3YzL19faHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzIwMjQxMTE5MDIwODA3
LmNuN3VneG5oYmtxd3JyMmJAc3lub3BzeXMuY29tL19fOyEhQTRGMlI5R19wZyFlQmhqNTJRYWZf
d0dabUs3NFNMSFN3MnVKbHdXZ3lIRTcwUUZWTzNhWDhGZ1pQeXlremRyaUhxUUdHODhsOUdhYnNu
X2xYT1B6enVVVEVSR3hWT2IwZGdELXNDSDRUVSQgDQo+IFsyXSBodHRwczovL3VybGRlZmVuc2Uu
Y29tL3YzL19faHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzIwMjQxMTE5MjItcGFudHlob3Nl
LXBhbm9yYW1hLTZmMTZAZ3JlZ2toL19fOyEhQTRGMlI5R19wZyFlQmhqNTJRYWZfd0dabUs3NFNM
SFN3MnVKbHdXZ3lIRTcwUUZWTzNhWDhGZ1pQeXlremRyaUhxUUdHODhsOUdhYnNuX2xYT1B6enVV
VEVSR3hWT2IwZGdEeE1XRE0tMCQgDQo+IFszXSBodHRwczovL3VybGRlZmVuc2UuY29tL3YzL19f
aHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzVsNjVzZHNrZHpiZWh4YW1mZjVheDRwdGlxaGF4
aDdld2k0dW10cHA2eW5lbjQ1bmo2QG5lYnV4amc0YzRyeC9fXzshIUE0RjJSOUdfcGchZUJoajUy
UWFmX3dHWm1LNzRTTEhTdzJ1Smx3V2d5SEU3MFFGVk8zYVg4RmdaUHl5a3pkcmlIcVFHRzg4bDlH
YWJzbl9sWE9Qenp1VVRFUkd4Vk9iMGRnRHMtTUZfNk0kIA0KPiB2NDoNCj4gICAtIFJlbW92ZSBv
dXQgb2YgY29udGV4dCBwYXJhZ3JhcGggZnJvbSBjb21taXQgbWVzc2FnZSBhcyBwZXIgDQo+ICAg
ICBUaGluaCBOZ3V5ZW4nc1sxXQ0KPiAgIC0gRml4IFJlcG9ydGVkLWJ5LCBjb3JyZWN0bHkgYXR0
cmlidXRlIHJlcG9ydCB0byBTdGVwaGVuIFJvdGh3ZWxsDQo+IA0KPiBbMV0gaHR0cHM6Ly91cmxk
ZWZlbnNlLmNvbS92My9fX2h0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC8yMDI0MTExOTIyMTkw
Ny50eXQ0bHVib2R1YXltdWtsQHN5bm9wc3lzLmNvbS9fXzshIUE0RjJSOUdfcGchZUJoajUyUWFm
X3dHWm1LNzRTTEhTdzJ1Smx3V2d5SEU3MFFGVk8zYVg4RmdaUHl5a3pkcmlIcVFHRzg4bDlHYWJz
bl9sWE9Qenp1VVRFUkd4Vk9iMGRnRHVkcUJUTlEkIA0KPiAtLS0NCj4gIGRyaXZlcnMvdXNiL2R3
YzMvY29yZS5oIHwgMSAtDQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBkZWxldGlvbigtKQ0KPiANCj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5oIGIvZHJpdmVycy91c2IvZHdjMy9j
b3JlLmgNCj4gaW5kZXggZWU3Mzc4OTMyNmJjLi4zYmUwNjljNDUyMGUgMTAwNjQ0DQo+IC0tLSBh
L2RyaXZlcnMvdXNiL2R3YzMvY29yZS5oDQo+ICsrKyBiL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5o
DQo+IEBAIC05NTYsNyArOTU2LDYgQEAgc3RydWN0IGR3YzNfcmVxdWVzdCB7DQo+ICAJc3RydWN0
IHVzYl9yZXF1ZXN0CXJlcXVlc3Q7DQo+ICAJc3RydWN0IGxpc3RfaGVhZAlsaXN0Ow0KPiAgCXN0
cnVjdCBkd2MzX2VwCQkqZGVwOw0KPiAtCXN0cnVjdCBzY2F0dGVybGlzdAkqc2c7DQo+ICAJc3Ry
dWN0IHNjYXR0ZXJsaXN0CSpzdGFydF9zZzsNCj4gIA0KPiAgCXVuc2lnbmVkIGludAkJbnVtX3Bl
bmRpbmdfc2dzOw0KPiAtLSANCj4gMi40Ny4wDQo+IA0KDQpBY2tlZC1ieTogVGhpbmggTmd1eWVu
IDxUaGluaC5OZ3V5ZW5Ac3lub3BzeXMuY29tPg0KDQpUaGFua3MsDQpUaGluaA==

