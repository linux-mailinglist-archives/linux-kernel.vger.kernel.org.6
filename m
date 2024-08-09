Return-Path: <linux-kernel+bounces-281645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8929B94D942
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 01:43:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE1AC1C20D4C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 23:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FC3D16D4FA;
	Fri,  9 Aug 2024 23:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="V3CDI6AI";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="R93e/O1+";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="KW2kAEB9"
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45EBA1B969;
	Fri,  9 Aug 2024 23:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723246982; cv=fail; b=TtHs9aT4NkUX30WdKuYObMOrZRGUGSU8SDloIARukouhst1Lmxmh4wgYjYnr49SjzcKQVid/F1p1c324YojCdHkAiSirtdu6oXwTdDDrZZ7AWfnA2HIXcYENrg8q0/ZZ4JRDFLd1xASFCJFYCH7BA5/Z63J/x+xjYnDPz7IG1nA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723246982; c=relaxed/simple;
	bh=9RJEjufxfaxIghhdHeu21a0s45guKGBKqcFbGdGqr1g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=I/5yAZ5S3h2Q/QzpZo0a6rt+QPBPRiKMlAOIkFQkoZlJPdzqNPBaLv5bO3iUxfOHLBl4Vl7fP3V24nEA00OPxV/ojCQrtJeJBdyjF2Ozrpxlmurm6nwE6Tv3b8/NpwsAw1S0AgS2CoQm/WVUgrRgXfij7Wfy8dPp7o1i0jjZM+g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=V3CDI6AI; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=R93e/O1+; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=KW2kAEB9 reason="signature verification failed"; arc=fail smtp.client-ip=148.163.158.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0297265.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 479MC11k021031;
	Fri, 9 Aug 2024 16:42:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=9RJEjufxfaxIghhdHeu21a0s45guKGBKqcFbGdGqr1g=; b=
	V3CDI6AIXV9Rrgzlgu1TEsKF06KQ5PUqzfGF6oY9XRp6tTTnS08EbgGdyJ27YF62
	XA3+ZdK+poHk5WMkOe+x/xl6QKdv9aZTWfysG590oEiyQgIBOpgn7G7Ct+oVvbbB
	ITStAAtMjySqVSyJtSzOz7WSF2JQAMUuh+595FIhK7r4blzGoweAVQyOlUMIYoQo
	HdvIRNEtthCVyV3hbRS6N0WC6Jl/aG0ReZAMhEnMLgiXvV+xmCht7Z47gMEpaQQh
	LaFp6xv1pkDkvsf2Mbcr3z066CU8QyeYWUOroEawGvcZTGVnTbs1hV8cG2q6a/7u
	IK4hf91ACdBS4Idel40Wqg==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 40uujatde1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 Aug 2024 16:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1723246972; bh=9RJEjufxfaxIghhdHeu21a0s45guKGBKqcFbGdGqr1g=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=R93e/O1+Kouq80hfSWXyv6qHneUpczdro06rJKwL0KezUhra2dtY60NHH2rk6Y+yW
	 Y8AJXnPUSZOn8WBirGxOYCg3//SAFkQCUTtnz6b57ni5ld4eqxPp1+pv+rzG8Hk1+x
	 RR7nQ8HPFZPKQJGqyf7AiIrBspL3E5DCNZf/UrhlYN9Y9vYIsr2G5f42+j30JSOfC7
	 iPJ3+SngJm1IXdFvTZWNlySp21DPAtvbfVgMN/dzfyqI+cVtoVEY1koEQj3wLDGrFk
	 H6PC6CKM8GkmFaYCFvia9KEeEJMfr+uG6M89A7GTAK93rF9R26LrnEp1H9OB3blGsd
	 9P9iBpXoHy8FQ==
Received: from mailhost.synopsys.com (sv1-mailhost2.synopsys.com [10.205.2.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 242E74052D;
	Fri,  9 Aug 2024 23:42:52 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
	by mailhost.synopsys.com (Postfix) with ESMTPS id B7955A0073;
	Fri,  9 Aug 2024 23:42:50 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=KW2kAEB9;
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 8096B40147;
	Fri,  9 Aug 2024 23:42:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C9d+Jmqnj6LGpsDNUx3Hucc+y8wXtr3LU712pCq0ftY+gFNo7H2c0eUEMK+/B5DfknRWB8eaZLXtKGm0jDqRDnm0tvmOQ90F/epYw+HzKsQ77jXL7uIw5YB++mWeohcZTtfAnpZwpEN/Z4ViwYVSaPvEADeiJNReSPvoqQMIWYrKLSPZTnoA+K8G9TcNoRyUJ+DuJIEuh4MQyOVkILzFFylW5VQqfkoikiz1a5z3ovNWjXWHj/5ZIeaD2R9kU0bIsg3Fp7UdqqxhzAFfjV5LaY63kwIpD4FLbVqKSav85X+PYgl2LYVnBq6BwAy7dsJnkw2Uyd74JW3S9pzX2kIXaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9RJEjufxfaxIghhdHeu21a0s45guKGBKqcFbGdGqr1g=;
 b=SJjvSiHVoNnzR/q0KJ7v9tuZfLOmjQd/OgZ0a30NP4HJhbbLRa8uJORoH8CySkwxEH5YVR6lO/uhXK6Ju0c0ie6RgDK62mLzpGX9WR0VWvS6oytkci/OlFSulQ9vMt636yQIvpT0XLndDN7d8S2h8/mB3MGXYyTnnKwnMOEtb4VRZ5oQGD+alaGoRtHHdseEr1GGmL2dj6xGkq6zROURrroxwOjawTDtchh91HI8NU9TpHkOHDu2/wfHOaFbItvTBCqZ6gafycZXKcFth3ExqCPET38WWaWOQt6PS9HCu74DJHwO8m6K84lz9tWN8eVe8DHkhWSMXGreAx/0D7Ty+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9RJEjufxfaxIghhdHeu21a0s45guKGBKqcFbGdGqr1g=;
 b=KW2kAEB9jnnMOG8v+SuWjgOxYsQdOfRezH7kaA/tvDcWy5rqFBh45CZ/3gV0Y4sRNMrJ6UaIoWGpf2hedQh95Zd78GRrd85C4IVLB9MBCCxAr2/5s8JzsEgyI9ywYb6MUa+SW3eY5kuKq96Q+QmCEyiKRVos03bCD7lWWyB3u6w=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by MN2PR12MB4374.namprd12.prod.outlook.com (2603:10b6:208:266::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.15; Fri, 9 Aug
 2024 23:42:47 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%5]) with mapi id 15.20.7849.014; Fri, 9 Aug 2024
 23:42:47 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Selvarasu Ganesan <selvarasu.g@samsung.com>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jh0801.jung@samsung.com" <jh0801.jung@samsung.com>,
        "dh10.jung@samsung.com" <dh10.jung@samsung.com>,
        "naushad@samsung.com" <naushad@samsung.com>,
        "akash.m5@samsung.com" <akash.m5@samsung.com>,
        "rc93.raju@samsung.com" <rc93.raju@samsung.com>,
        "taehyun.cho@samsung.com" <taehyun.cho@samsung.com>,
        "hongpooh.kim@samsung.com" <hongpooh.kim@samsung.com>,
        "eomji.oh@samsung.com" <eomji.oh@samsung.com>,
        "shijie.cai@samsung.com" <shijie.cai@samsung.com>
Subject: Re: [PATCH] usb: dwc3: Potential fix of possible dwc3 interrupt storm
Thread-Topic: [PATCH] usb: dwc3: Potential fix of possible dwc3 interrupt
 storm
Thread-Index: AQHa2cstTT8AcV9+kEe9fm+4hVNVnLIbEIwAgABflQCAAT06AIAAVgGAgAK0ooA=
Date: Fri, 9 Aug 2024 23:42:46 +0000
Message-ID: <20240809234227.eriwy5e6leatzdyh@synopsys.com>
References:
 <CGME20240719110149epcas5p3dd468685a095c094ed2e540279bf3ec2@epcas5p3.samsung.com>
 <20240719110100.329-1-selvarasu.g@samsung.com>
 <20240807003806.5owtgwgw2lczg4u5@synopsys.com>
 <b6baeb45-1684-4fcb-8c71-392cb4788c85@samsung.com>
 <20240808011536.oid627ez4ppdfkhp@synopsys.com>
 <b48e7aba-6c54-431f-bbb5-3e5490df0c1a@samsung.com>
In-Reply-To: <b48e7aba-6c54-431f-bbb5-3e5490df0c1a@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|MN2PR12MB4374:EE_
x-ms-office365-filtering-correlation-id: 51c56ad0-fcf7-465f-cd2b-08dcb8ccf8f3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|7416014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?TVFWWkNlYUxsTzVSZWdVSFZSSkc5bEVLMDhDYmVtN2diZE96ZlBoTU9wVW9E?=
 =?utf-8?B?Ry8vL3dZeHlhd3JEUDMyL2lxWFlFdWE2Q0s4ekRCcTlobGs4aWVtZHZiNDVU?=
 =?utf-8?B?bUlpU3BhSEJMalh4S0trUXBjSDhRTDRIZ0JDN25YRHdkam9weEcwRkY0a3ZC?=
 =?utf-8?B?VDVyVk5HWWdFL1kzTUNBVDNZQ0NENWl0c3cvVjdtTHhIOHRMN0xrRUdiQURV?=
 =?utf-8?B?TjNjUytYMEtQaG9TOUJLTGJDT3VBd0lGb1B2c2lQWERwZ3hhaWU5Y09uVEU1?=
 =?utf-8?B?aWVlY3FwdnhIT2d0UDZ5MThUM3RmbHBvelA3R1RGYjNsTEFlejVhVjdZZFor?=
 =?utf-8?B?cHMrSm5hVUp3YkxPSlgwUXgwNzlGbnhtNDV2OHJVQ1ZsTzk2TWhxeHhiQ1FP?=
 =?utf-8?B?NzRPdmV6c3ZtVzVNR3ZHZitSeEpwdTNKQkNUc0ZuYmZvVmtJNmJQR3hLb2R6?=
 =?utf-8?B?TC9NQ1ZUMkliZXVKZGtpM2FGTnV1ZlNJN0lZMWRZNStDamovYW9kVkZVOC9w?=
 =?utf-8?B?U2w5Sjl2aFJmc2lKSVMzMTJ1anUyTWlTeTBPTndZRDAvNmovRVYwQ09RSG4z?=
 =?utf-8?B?cXZBZG5XWUw2L2ZWd01DbXFTUVU0WlY3cGJpRzlnb24zMmVwNkgxT0V1Y2pu?=
 =?utf-8?B?Qk12aitMcXdLVG5neHJ3bGdqS3lGNmRPUTI4eWluNVlVZEd4VDBFNEd5YzZT?=
 =?utf-8?B?SEFMakdSV0krbHc5bTI1a25KdTdOK2Y5dWhnSEdnOVJTSjNOeUEzV3AzbjMz?=
 =?utf-8?B?OFJZYmZNcWRyQ2ZBNWZhdmVITVNlU2haaldmZlJOWHZ5M05JV21rRzEwR2NX?=
 =?utf-8?B?Q1I2c1FXQzI3bmROVFEwQ0JiSkNJR2ZEQlFNSFZzeGxPUHN1MHRPbUZEaGk5?=
 =?utf-8?B?QVRydEVkNXZpNzN4d3JxN09td1lLTVlFQlZ6OTVRYnB5dzI0N0l5UElOUVNs?=
 =?utf-8?B?SUR1MWRZdkhuTGxpU3YxbUQ1UlpKVFp4Y1RpRm5waE44K3JqK0JscTRqRVg3?=
 =?utf-8?B?N3FpSTdRdG9aVVV1MnJrYVhEU0V2NlJQcHRvQTF6d0c1Z1F1enZJTmQrSVI0?=
 =?utf-8?B?aXZ0LzVkZyttRHpCZEtPK1ZVS1JLWTZUc0NGZ0VJRFgrYnRmZjBFRXd1WU5E?=
 =?utf-8?B?bWFsNUZLcnpJVldhVjdHZjlIUTNRVDJVU3BCS1AvbUdOZTV2NHZTKzE0YXRj?=
 =?utf-8?B?bGRFOU1jcFYvSXlhaWFTNUJhQ3dNT0hUODg0Ym00T1cxeERVUjZ0MllzVlFt?=
 =?utf-8?B?V1Y2Z0NKam42RVNId0lJZkFOYlJvazBFLzR2RzUvRlBvcGJjbnlLNjFOQ0RM?=
 =?utf-8?B?OElYOHBQN3pISURBbVNoa3BjRFI4bWxEeE16UCthL0xTVmt5TnRvTHNLNStO?=
 =?utf-8?B?d2JmcmlRdGNOY0FWdVNVYzVzeWcrT0E1YmxiZ0h6aGRnODYzZnE5RXhaOXFj?=
 =?utf-8?B?Wnk1VGhtS2tPMVYrMEcvUDRRVng1MjZHbncrOTVyOUEwbE5WelB6Tzg2Vm04?=
 =?utf-8?B?TDhKK3hVZWxSeXluRFN3YUcxbmhBSnkxOU5zcnEyWWtpME5Cc0QrWVJyZW1F?=
 =?utf-8?B?ZGwwN0JvV1ZZZGJoSWcvRG4vbEd0MXVYQUlLS3daTkRZTERwSmlEWnFxeE05?=
 =?utf-8?B?NFEwbDdVaE9CQUJoYjM0S2RDNWg3aWxNdFZhRmVqNWNkU1R3akV1bFdmaGNp?=
 =?utf-8?B?dGFOR1ltQi9oaksrTzFwSDVtU1BWZ1E3QmZvNHpwRnVHNkxiMVRQR3ZIUUhx?=
 =?utf-8?B?RWNpK2tlRG9BUzhjdHhHWUc4aW5iY2lSUlJIcW1yeTFKc0czVDJzVzFnNWNx?=
 =?utf-8?B?bVpaNTdRWFpDeXJJMVBNek0vSDBSK1BBZFF2TE1MdWJNbllnYkp4MTZKSkp2?=
 =?utf-8?B?eXhkc1BIV0NJT0twQWpPenEwVURjWVRLQngxZm4xN090WXc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VlQvc1B2SVVrV1JTYmhMK0RBQVNmeEtyRTFDcThhR0NCcDQvcjBtMDR3OWFX?=
 =?utf-8?B?UmxvbHZXdGpKNkMyZEh0MnlsZmFaSHlXdjdRdTVXUGc0aHBqeGg2dVcyRXBW?=
 =?utf-8?B?MzBMSEliRXp4RjZIOEpDdUxTZE9renZla2pWd3c5UmQyRHNtYUQxNlNlTzJS?=
 =?utf-8?B?azRxZ010V0p1YnNyZE9TWCtJeDluNUpzZnpxVTgyUXZ2QjJDazN3alc4RXJw?=
 =?utf-8?B?UDkvNmFMRzZ5U0lRUzBabjR0YjZ0Tm9xbE5JT0t5RUVvdmYyYSsvbzhDcU5w?=
 =?utf-8?B?dzNLKytTSm1mQnFNZDZsdnhmYXFVbzBiallRY2ZHMHVrdkZEWTA5blhmcVNy?=
 =?utf-8?B?b0lzVGI1aU1XT2JYc1Y2RGlmRTNFTUFQRkdvWG5tREdWUklvR0ZLR1RWYlJN?=
 =?utf-8?B?VjA0bVVERUlrTzQrUDkwcUFnT0xzbmZKWmJ3MnM3RFp3MkM1K1N6UFkvcE1E?=
 =?utf-8?B?L0pwWlI4aS9uVUhZQ0svQ3Nva0FpTDNGUi84dXhyOHA1emF5c0U0ZXpMUU5i?=
 =?utf-8?B?OVNPQ2g0UnZCTHJDOWo4bGhIUWZBcm1WaXpqU1JxYjk2UEZHeXEvMjFuM1hZ?=
 =?utf-8?B?Q0IrcUxKUlRsNHgwTExpUldEK05QSUpFNUpES2Rud0F1c1Z2NTFsMGw5WHlG?=
 =?utf-8?B?ZTlsTHY2K08wRFFGK0dpck52K1NrRFB2T01wcUZYOUpEb0pZL1NaanZQZ0ZR?=
 =?utf-8?B?RTFrUDJ4dE1maGVaSGV4akRkdkpDMW8zT1YrZXEzN2JjcjBlRzFxY09TV0Iy?=
 =?utf-8?B?ZTlwcDI1VWFZSWVvTmQvbFRJNnlNSXRXdmgreFNZWWVPYUdURDdKUUJtSnJX?=
 =?utf-8?B?TnhiZHBHQkcySTA4Vyt5TGJpMHRMVmc1RmY5VytTOWxOVEk1TUxZQmEwY0Ro?=
 =?utf-8?B?U0ZIMGVPdVRpelZVZXhpZzg3SU5TTWhnY0xCYUt4ZlQ1SnIzVDFvR05hdzIv?=
 =?utf-8?B?K2dJTTR3S2w3L2s1L3FSWElQRk53VXJ4QWhWUnJ2eUVSNkV5TDVINVRBcTI3?=
 =?utf-8?B?cDNFektPc3BSQW5xc2s1dC9mdmZoRStFMmEzZHRwQnFYcFNFclEvYlEyVjVH?=
 =?utf-8?B?aENyTzhuRkVKcng2VjYzSmEzK0ZqUFg0NmhSM0cwSjIyOUxFSWt4b1QyMmRS?=
 =?utf-8?B?LzhtaWMxL1VkUDVDaVBXbUNxcFIrL2NadjI2OWI1YnpXZlV3UUd4WHdXVWVw?=
 =?utf-8?B?cFNNWDNvM25UT242RDR5bmppU2dCVnZLeUZQQVFoUjVmOWtiUmx1WEVaZWE0?=
 =?utf-8?B?MmhNWS8xYWVMQjJDMm5pOEdKVm1xZ2R6OFNDODFrZ29acm5RNEI4b3FJVzZW?=
 =?utf-8?B?K0RrM2gyMjJhZzhlTm9zNkM3Zjh4dEc5K0lVaFlneXYrV3VOamkwcU9TeUJC?=
 =?utf-8?B?YTN4UjJadlBibkNiNG9lS29MNzdTTkZzZXJQTVI5cmQrWkx6cFVCQW5oR0Fw?=
 =?utf-8?B?OTRVQWlZS3ZlNzdrYzNwOTYwaVNGVjJMamxDMklKdnFZUGh1L2FuMWJkQlVH?=
 =?utf-8?B?bnBqNDJuNDZLREptZXNkS3lnYnJMTDBOSHYwQXdRbVRRamcyUTFMYjRPUHA4?=
 =?utf-8?B?VUh0aHRpNm52ajlmMUNpbXVYWWVINTBpUTBPdXBsSjBIVWszMmNNdWxVVEZr?=
 =?utf-8?B?cXljRFhxK09VcFJvNHlmeTQya2JXWktlbExkajFESUpXcVIvU0pLb3JvTXRF?=
 =?utf-8?B?OWEvZUNqVi9TU2JTRVBZVWlWY0dyZStvbmdPTHJVamJrZ0xsalhrMWtnVTRi?=
 =?utf-8?B?aUs5V0RYYXV2d0tTdGc1T3h4WnhjNE1XRm83dndtQmMzY0x1VGk4VVhTLzFk?=
 =?utf-8?B?cGhFbC9wSTVuUkZ1aUdoN2FCOGpkQmhBaTZTa1NxenlUQlNCR2wyRytSTENP?=
 =?utf-8?B?UWRoSmpsRUtNblBzV1hVcXRrTGJvRFYxZTZXVkNPbWMyVGs2RjFmaDFxYXp4?=
 =?utf-8?B?K00vaitnN0hiOVd4UDlvdUtZTEVxMHdaUXJsc0g5dTREOWVQdGJ4UmtIdkRk?=
 =?utf-8?B?SDFKL1ljYlkrZ1BMMUFBUE9JeEQ4a2lhelA2cmFkb1N6c0dXMm9xZGdBYzFT?=
 =?utf-8?B?bkd3MXcwcVEyQlMvZzlUek9zZThQSnZwekVrWTEyKzRCM0gyT1J2N1FreWlV?=
 =?utf-8?B?NzRmeXpJRjNDRmhuaEIwRDFzbzRiNlJwaWw5RnBZRXZDNkIrbWl1MHFiRURM?=
 =?utf-8?B?eHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6CA53FE7E058F242874BE3EAEA6611AE@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	YTqa/s2albbRgxWnlbTTHYVEdtptEfMR9weKcl6rG6QxFaOPRoZkFTfSm7SD1FPHaBHOanKTlYcMLHud0ca8DtTEQGthf8S0ze7nOclzZGUJ+B2Bmt/v2RZBhyMpZREQJVcDju/yQoa2dj9Kwsfi2o8gfvElqz2OA0dzwggWZC9OocZmvJb+9oNmXdFXyZjREqR8d5wM4eExQutENiL9hvqYRz/AnNrmb2tUvQq3OaVhQqzjyoM7jQ1ehi5kPB6FDDeUadc/38CACOcYSQYzn2PRGA7dVU/jHlx536BNA6ys+W4XC2bepWYU9q+B42imFPVCohbc/eLCi+mdLfs8KOxzyqQR0iY7fOUU/85lWavaIWwqYUHafzyU+f8A8GpLcpuEVR2kGIY/yNRnJuSEi7oGZHKJ/VunbYd8R7iQlkYerWtrWavg1RxkIoRnRgVcypvK0QK7OkIomgAwUcm61m8CQx/YrnNUREhEKzGuSH6jgmpksDbclgdx6KZnElfhqjP90D7o4drbtDffYW8xhAZB8WA0aRIBotHJIFN9v0eDBWqLaTwzyQx3LNEGYdSvT3tTmC3XFTKHYcbJBKX9KgxcDuWaVHLYVP+k587QbuQF6X+KG3NEZxjs3fWF3X2HeDX/RE/oEUgAb4/jW3CdLw==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51c56ad0-fcf7-465f-cd2b-08dcb8ccf8f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2024 23:42:46.9263
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OAdsJe8gc61PKspknhJOTgK/tZnU573L1x+xIv7UcNw7fdnrTY7fBtvw4VepaaeNu0cIc1PAf1780VQTO0JnTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4374
X-Proofpoint-GUID: AYTzkJQYQfGGhVlbpNfuE2Qbv-sUsf9L
X-Proofpoint-ORIG-GUID: AYTzkJQYQfGGhVlbpNfuE2Qbv-sUsf9L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-09_18,2024-08-07_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 adultscore=0 priorityscore=1501 bulkscore=0 mlxlogscore=999 clxscore=1015
 lowpriorityscore=0 malwarescore=0 phishscore=0 impostorscore=0 mlxscore=0
 suspectscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408090172

T24gVGh1LCBBdWcgMDgsIDIwMjQsIFNlbHZhcmFzdSBHYW5lc2FuIHdyb3RlOg0KPiANCj4gT24g
OC84LzIwMjQgNjo0NSBBTSwgVGhpbmggTmd1eWVuIHdyb3RlOg0KPiA+IE9uIFdlZCwgQXVnIDA3
LCAyMDI0LCBTZWx2YXJhc3UgR2FuZXNhbiB3cm90ZToNCj4gPj4gT24gOC83LzIwMjQgNjowOCBB
TSwgVGhpbmggTmd1eWVuIHdyb3RlOg0KPiA+Pj4gT24gRnJpLCBKdWwgMTksIDIwMjQsIFNlbHZh
cmFzdSBHYW5lc2FuIHdyb3RlOg0KPiA+Pj4+IEluIGNlcnRhaW4gc2NlbmFyaW9zLCB0aGVyZSBp
cyBhIGNoYW5jZSB0aGF0IHRoZSBDUFUgbWF5IG5vdCBiZQ0KPiA+Pj4+IHNjaGVkdWxlZCB0aGUg
Ym90dG9tIGhhbGYgb2YgZHdjMyBpbnRlcnJ1cHQuIFRoaXMgaXMgYmVjYXVzZSB0aGUgQ1BVDQo+
ID4+Pj4gbWF5IGhhbmcgdXAgd2hlcmUgYW55IHdvcmsgcXVldWUgbG9ja3VwIGhhcyBoYXBwZW5l
ZCBmb3IgdGhlIHNhbWUgQ1BVDQo+ID4+Pj4gdGhhdCBpcyB0cnlpbmcgdG8gc2NoZWR1bGUgdGhl
IGR3YzMgdGhyZWFkIGludGVycnVwdC4gSW4gdGhpcyBzY2VuYXJpbywNCj4gPj4+PiB0aGUgVVNC
IGNhbiBlbnRlciBydW50aW1lIHN1c3BlbmQgYXMgdGhlIGJ1cyBtYXkgaWRsZSBmb3IgYSBsb25n
ZXIgdGltZQ0KPiA+Pj4+ICwgb3IgdXNlciBjYW4gcmVjb25uZWN0IHRoZSBVU0IgY2FibGUuIFRo
ZW4sIHRoZSBkd2MzIGV2ZW50IGludGVycnVwdA0KPiA+Pj4+IGNhbiBiZSBlbmFibGVkIHdoZW4g
cnVudGltZSByZXN1bWUgaXMgaGFwcGVuaW5nIHdpdGggcmVnYXJkbGVzcyBvZiB0aGUNCj4gPj4+
PiBwcmV2aW91cyBldmVudCBzdGF0dXMuIFRoaXMgY2FuIGxlYWQgdG8gYSBkd2MzIElSUSBzdG9y
bSBkdWUgdG8gdGhlDQo+ID4+Pj4gcmV0dXJuIGZyb20gdGhlIGludGVycnVwdCBoYW5kbGVyIGJ5
IGNoZWNraW5nIG9ubHkgdGhlIGV2dC0+ZmxhZ3MgYXMNCj4gPj4+PiBEV0MzX0VWRU5UX1BFTkRJ
TkcsIHdoZXJlIHRoZSBzYW1lIGZsYWcgd2FzIHNldCBhcyBEV0MzX0VWRU5UX1BFTkRJTkcNCj4g
Pj4+PiBpbiBwcmV2aW91cyB3b3JrIHF1ZXVlIGxvY2t1cC4NCj4gPj4+PiBMZXQncyBjb25zaWRl
ciB0aGUgZm9sbG93aW5nIHNlcXVlbmNlcyBpbiB0aGlzIHNjZW5hcmlvLA0KPiA+Pj4+DQo+ID4+
Pj4gQ2FsbCB0cmFjZSBvZiBkd2MzIElSUSBhZnRlciB3b3JrcXVldWUgbG9ja3VwIHNjZW5hcmlv
DQo+ID4+Pj4gPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09DQo+ID4+Pj4gSVJRICMxOg0KPiA+Pj4+IC0+ZHdjM19pbnRlcnJ1cHQoKQ0KPiA+Pj4+
ICAgICAtPmR3YzNfY2hlY2tfZXZlbnRfYnVmKCkNCj4gPj4+PiAgICAgICAgICAgLT5pZiAoZXZ0
LT5mbGFncyAmIERXQzNfRVZFTlRfUEVORElORykNCj4gPj4+PiAgICAgICAgICAgICAgICAgICAg
ICAgIHJldHVybiBJUlFfSEFORExFRDsNCj4gPj4+PiAgICAgICAgICAgLT5ldnQtPmZsYWdzIHw9
IERXQzNfRVZFTlRfUEVORElORzsNCj4gPj4+PiAgICAgICAgICAgLT4vKiBEaXNhYmxlIGludGVy
cnVwdCBieSBzZXR0aW5nIERXQzNfR0VWTlRTSVpfSU5UTUFTSyAgaW4NCj4gPj4+PiAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgRFdDM19H
RVZOVFNJWg0KPiA+Pj4+ICAgICAgICAgICAtPnJldHVybiBJUlFfV0FLRV9USFJFQUQ7IC8vIE5v
IHdvcmtxdWV1ZSBzY2hlZHVsZWQgZm9yIGR3YzMNCj4gPj4+PiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICB0aHJlYWRfZnUgZHVlIHRvIHdvcmtxdWV1ZSBsb2NrdXANCj4g
Pj4+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBldmVuIGFmdGVyIHJl
dHVybiBJUlFfV0FLRV9USFJFQUQNCj4gPj4+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBmcm9tIHRvcC1oYWxmLg0KPiA+Pj4+DQo+ID4+Pj4gVGhyZWFkICMyOg0KPiA+
Pj4+IC0+ZHdjM19ydW50aW1lX3Jlc3VtZSgpDQo+ID4+Pj4gICAgLT5kd2MzX3Jlc3VtZV9jb21t
b24oKQ0KPiA+Pj4+ICAgICAgLT5kd2MzX2dhZGdldF9yZXN1bWUoKQ0KPiA+Pj4+ICAgICAgICAg
LT5kd2MzX2dhZGdldF9zb2Z0X2Nvbm5lY3QoKQ0KPiA+Pj4+ICAgICAgICAgICAtPmR3YzNfZXZl
bnRfYnVmZmVyc19zZXR1cCgpDQo+ID4+Pj4gICAgICAgICAgICAgIC0+LypFbmFibGUgaW50ZXJy
dXB0IGJ5IGNsZWFyaW5nICBEV0MzX0dFVk5UU0laX0lOVE1BU0sgaW4NCj4gPj4+PiAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgRFdDM19H
RVZOVFNJWiovDQo+ID4+Pj4NCj4gPj4+PiBTdGFydCBJUlEgU3Rvcm1pbmcgYWZ0ZXIgZW5hYmxl
IGR3YzMgZXZlbnQgaW4gcmVzdW1lIHBhdGgNCj4gPj4+PiA9PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0NCj4gPj4+PiBDUFUwOiBJUlENCj4g
Pj4+PiBkd2MzX2ludGVycnVwdCgpDQo+ID4+Pj4gICAgZHdjM19jaGVja19ldmVudF9idWYoKQ0K
PiA+Pj4+ICAgICAgICAgICBpZiAoZXZ0LT5mbGFncyAmIERXQzNfRVZFTlRfUEVORElORykNCj4g
Pj4+PiAgICAgICAgICAgIHJldHVybiBJUlFfSEFORExFRDsNCj4gPj4+Pg0KPiA+Pj4+IENQVTA6
IElSUQ0KPiA+Pj4+IGR3YzNfaW50ZXJydXB0KCkNCj4gPj4+PiAgICBkd2MzX2NoZWNrX2V2ZW50
X2J1ZigpDQo+ID4+Pj4gICAgICAgICAgIGlmIChldnQtPmZsYWdzICYgRFdDM19FVkVOVF9QRU5E
SU5HKQ0KPiA+Pj4+ICAgICAgICAgICAgcmV0dXJuIElSUV9IQU5ETEVEOw0KPiA+Pj4+IC4uDQo+
ID4+Pj4gLi4NCj4gPj4+Pg0KPiA+Pj4+IFRvIGZpeCB0aGlzIGlzc3VlIGJ5IGF2b2lkaW5nIGVu
YWJsaW5nIG9mIHRoZSBkd2MzIGV2ZW50IGludGVycnVwdCBpbg0KPiA+Pj4+IHRoZSBydW50aW1l
IHJlc3VtZSBwYXRoIGlmIGR3YzMgZXZlbnQgcHJvY2Vzc2luZyBpcyBpbiBwcm9ncmVzcy4NCj4g
Pj4+Pg0KPiA+Pj4+IFNpZ25lZC1vZmYtYnk6IFNlbHZhcmFzdSBHYW5lc2FuIDxzZWx2YXJhc3Uu
Z0BzYW1zdW5nLmNvbT4NCj4gPj4+PiAtLS0NCj4gPj4+PiAgICBkcml2ZXJzL3VzYi9kd2MzL2Nv
cmUuYyB8IDggKysrKysrLS0NCj4gPj4+PiAgICAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25z
KCspLCAyIGRlbGV0aW9ucygtKQ0KPiA+Pj4+DQo+ID4+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
dXNiL2R3YzMvY29yZS5jIGIvZHJpdmVycy91c2IvZHdjMy9jb3JlLmMNCj4gPj4+PiBpbmRleCBj
YjgyNTU3Njc4ZGQuLjYxMDc5MmE3MDgwNSAxMDA2NDQNCj4gPj4+PiAtLS0gYS9kcml2ZXJzL3Vz
Yi9kd2MzL2NvcmUuYw0KPiA+Pj4+ICsrKyBiL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5jDQo+ID4+
Pj4gQEAgLTU0OSw4ICs1NDksMTIgQEAgaW50IGR3YzNfZXZlbnRfYnVmZmVyc19zZXR1cChzdHJ1
Y3QgZHdjMyAqZHdjKQ0KPiA+Pj4+ICAgIAkJCWxvd2VyXzMyX2JpdHMoZXZ0LT5kbWEpKTsNCj4g
Pj4+PiAgICAJZHdjM193cml0ZWwoZHdjLT5yZWdzLCBEV0MzX0dFVk5UQURSSEkoMCksDQo+ID4+
Pj4gICAgCQkJdXBwZXJfMzJfYml0cyhldnQtPmRtYSkpOw0KPiA+Pj4+IC0JZHdjM193cml0ZWwo
ZHdjLT5yZWdzLCBEV0MzX0dFVk5UU0laKDApLA0KPiA+Pj4+IC0JCQlEV0MzX0dFVk5UU0laX1NJ
WkUoZXZ0LT5sZW5ndGgpKTsNCj4gPj4+PiArDQo+ID4+Pj4gKwkvKiBTa2lwIGVuYWJsZSBkd2Mz
IGV2ZW50IGludGVycnVwdCBpZiBldmVudCBpcyBwcm9jZXNzaW5nIGluIG1pZGRsZSAqLw0KPiA+
Pj4+ICsJaWYgKCEoZXZ0LT5mbGFncyAmIERXQzNfRVZFTlRfUEVORElORykpDQo+ID4+Pj4gKwkJ
ZHdjM193cml0ZWwoZHdjLT5yZWdzLCBEV0MzX0dFVk5UU0laKDApLA0KPiA+Pj4+ICsJCQkJRFdD
M19HRVZOVFNJWl9TSVpFKGV2dC0+bGVuZ3RoKSk7DQo+ID4+Pj4gKw0KPiA+Pj4+ICAgIAlkd2Mz
X3dyaXRlbChkd2MtPnJlZ3MsIERXQzNfR0VWTlRDT1VOVCgwKSwgMCk7DQo+ID4+Pj4gICAgDQo+
ID4+Pj4gICAgCXJldHVybiAwOw0KPiA+Pj4+IC0tIA0KPiA+Pj4+IDIuMTcuMQ0KPiA+Pj4+DQo+
ID4+PiBXZSdyZSBub3Qgd2FraW5nIHVwIGZyb20gYSBoaWJlcm5hdGlvbi4gU28gYWZ0ZXIgYSBz
b2Z0LXJlc2V0IGFuZA0KPiA+Pj4gcmVzdW1lLCB0aGUgZXZlbnRzIHRoYXQgd2VyZW4ndCBwcm9j
ZXNzZWQgYXJlIHN0YWxlLiBUaGV5IHNob3VsZCBiZQ0KPiA+Pj4gcHJvY2Vzc2VkIHByaW9yIHRv
IGVudGVyaW5nIHN1c3BlbmQgb3IgYmUgZGlzY2FyZGVkIGJlZm9yZSByZXN1bWUuDQo+ID4+Pg0K
PiA+Pj4gVGhlIHN5bmNocm9uaXplX2lycSgpIGR1cmluZyBzdXNwZW5kKCkgd2FzIG5vdCBzdWZm
aWNpZW50IHRvIHByZXZlbnQNCj4gPj4+IHRoaXM/IFdoYXQgYXJlIHdlIG1pc3NpbmcgaGVyZS4N
Cj4gPj4+DQo+ID4+PiBUaGFua3MsDQo+ID4+PiBUaGluaA0KPiA+PiBJIGRvbuKAmXQgdGhpbmsg
dGhlIHRyaWdnZXJpbmcgb2YgaW50ZXJydXB0IHdvdWxkIG5vdCBiZSBzdG9wcGVkIGV2ZW4gaWYN
Cj4gPj4gZG8gc29mdCByZXNldC4gSXQncyBiZWNhdXNlIG9mIGV2ZW50IGNvdW50IGlzIG1heSBi
ZSB2YWxpZCAuDQo+ID4gT2suIEkgdGhpbmsgSSBzZWUgd2hhdCB5b3UncmUgcmVmZXJyaW5nIHRv
IHdoZW4geW91IHNheSAiZXZlbnQgaXMNCj4gPiBwcm9jZXNzaW5nIGluIHRoZSBtaWRkbGUiIG5v
dy4NCj4gPg0KPiA+IFdoYXQgeW91IHdhbnQgdG8gY2hlY2sgaXMgcHJvYmFibHkgdGhpcyBpbiBk
d2MzX2V2ZW50X2J1ZmZlcnNfc2V0dXAoKS4NCj4gPiBQbGVhc2UgY29uZmlybToNCj4gPg0KPiA+
IGlmIChkd2MtPnBlbmRpbmdfZXZlbnRzKQ0KPiA+IAlkd2MzX3dyaXRlbChkd2MtPnJlZ3MsIERX
QzNfR0VWTlRTSVooMCksDQo+ID4gCQkJRFdDM19HRVZOVFNJWl9JTlRNQVNLIHwgRFdDM19HRVZO
VFNJWl9TSVpFKGV2dC0+bGVuZ3RoKSk7DQo+ID4gZWxzZQ0KPiA+IAlkd2MzX3dyaXRlbChkd2Mt
PnJlZ3MsIERXQzNfR0VWTlRTSVooMCksIERXQzNfR0VWTlRTSVpfU0laRShldnQtPmxlbmd0aCkp
Ow0KPiANCj4gWWVzLCB3ZSBhcmUgZXhwZWN0aW5nIHRoZSBzYW1lLiBCdXQsIHdlIG11c3QgdmVy
aWZ5IHRoZSBzdGF0dXMgb2YgDQo+IGV2dC0+ZmxhZ3MsIHdoaWNoIHdpbGwgaW5kaWNhdGUgd2hl
dGhlciB0aGUgZXZlbnQgaXMgY3VycmVudGx5IA0KPiBwcm9jZXNzaW5nIGluIG1pZGRsZSBvciBu
b3QuIFRoZSBiZWxvdyBjb2RlIGlzIGZvciB0aGUgcmVmZXJlbmNlLg0KPiANCj4gaWYgKCEoZXZ0
LT5mbGFncyAmIERXQzNfRVZFTlRfUEVORElORykpDQo+IAlkd2MzX3dyaXRlbChkd2MtPnJlZ3Ms
IERXQzNfR0VWTlRTSVooMCksDQo+IAkJCSBEV0MzX0dFVk5UU0laX1NJWkUoZXZ0LT5sZW5ndGgp
KTsNCj4gZWxzZQ0KPiAJZHdjM193cml0ZWwoZHdjLT5yZWdzLCBEV0MzX0dFVk5UU0laKDApLA0K
PiAJCQlEV0MzX0dFVk5UU0laX0lOVE1BU0sgfCBEV0MzX0dFVk5UU0laX1NJWkUoZXZ0LT5sZW5n
dGgpKTsNCg0KU28sIHRoaXMgaGFwcGVucyB3aGlsZSBwZW5kaW5nX2V2ZW50cyBpcyBzZXQgcmln
aHQ/IEkgbmVlZCB0byByZXZpZXcNCnRoaXMgcnVudGltZSBzdXNwZW5kIGZsb3cgbmV4dCB3ZWVr
LiBTb21ldGhpbmcgZG9lc24ndCBsb29rIHJpZ2h0LiBXaGVuDQp0aGVyZSdzIGEgc3VzcGVuZC9y
ZXN1bWUgcnVudGltZSBvciBub3QsIHRoZXJlJ3MgYSBzb2Z0IGRpc2Nvbm5lY3QuIFdlDQpzaG91
bGRuJ3QgYmUgcHJvY2Vzc2luZyBhbnkgZXZlbnQgcHJpb3IgdG8gZ29pbmcgaW50byBzdXNwZW5k
LiBBbHNvLCB3ZQ0Kc2hvdWxkbid0IGJlIGRvaW5nIHNvZnQtZGlzY29ubmVjdCB3aGlsZSBjb25u
ZWN0ZWQgYW5kIGluIG9wZXJhdGlvbg0KdW5sZXNzIHdlIHNwZWNpZmljYWxseSB0ZWxsIGl0IHRv
Lg0KDQo+IA0KPiA+PiBMZXQgY29uc2lkZXIgdGhlIHNjZW5hcmlvcyB3aGVyZSBTVyBpcyBub3Qg
YWNrbm93bGVkZ2UgdGhlIGV2ZW50IGNvdW50DQo+ID4+IGFmdGVyIGdldHRpbmcgYSBpbnRlcnJ1
cHQgd2l0aCBkaXNhYmxlIEdFVk5UU0laX0lOVE1BU0sgPTAuIEl0IHdpbGwNCj4gPj4gdHJpZ2dl
cmluZyB0aGUgc3B1cmlvdXMgaW50ZXJydXB0cyB1bnRpbCBlbmFibGUgR0VWTlRTSVpfSU5UTUFT
Sz0xIG9yDQo+ID4+IGFja25vd2xlZGdlIHRoZSBldmVudCBjb3VudCBieSBTVy4gVGhpcyBpcyBo
YXBwZW5pbmcgaGVyZSBiZWNhdXNlIG9mIFdlDQo+ID4+IGp1c3QgcmV0dXJuIGZyb20gaW50ZXJy
dXB0IGhhbmRsZXIgYnkgY2hlY2tpbmcgaWYgZXZ0LT5mbGFncyBhcw0KPiA+PiBEV0MzX0VWRU5U
X1BFTkRJTkcuIENsZWFyaW5nIG9mIERXQzNfRVZFTlRfUEVORElORyBmbGFnIGlzIGRvbmUgaW4N
Cj4gPj4gZHdjM190aHJlYWRfaW50ZXJydXB0LiBJbiBzb21lIHNjZW5hcmlvIGl0J3Mgbm90IGhh
cHBlbmluZyBkdWUgdG8gY3B1DQo+ID4+IGhhbmd1cCBvciB3b3JrIHF1ZXVlIGxvY2t1cC4NCj4g
PiBUaGlzIGNhbiBiZSBtaXRpZ2F0ZWQgYnkgYWRqdXN0aW5nIHRoZSBpbW9kX2ludGVydmFsIChp
bnRlcnJ1cHQNCj4gPiBtb2RlcmF0aW9uKS4gSGF2ZSB5b3UgdHJpZWQgdGhhdD8NCj4gDQo+IA0K
PiBZZXMgd2UgdHJpZWQgdG8gcGxheSBhcm91bmQgdGhlIGNoYW5naW5nIG9mIGltb2QgaW50ZXJ2
YWwgdmFsdWUgYnV0IG5vIA0KPiBpbXByb3ZlbWVudHMuDQoNCk9rLg0KDQpUaGFua3MsDQpUaGlu
aA==

