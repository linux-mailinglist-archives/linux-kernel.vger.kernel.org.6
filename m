Return-Path: <linux-kernel+bounces-213159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FB18906DCE
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 14:04:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF486B24CF0
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 12:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C929146A83;
	Thu, 13 Jun 2024 11:59:36 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E6FB143867;
	Thu, 13 Jun 2024 11:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718279975; cv=fail; b=WJdh8f/8GiIidYarZwpPLR1vDojJ49r16jkboPiAdw4MOCRk9ZonXw6R/dpz2v9fTwTOoQOxLSJowT8thUAdOhz7pA6e5yyVM6/M2FNC9zryN1bOzdz6OxOFcgjXAg12y5IV9F9vE/vAlX0h3nLAqsM+j0WpApyJCSAx23RDXU0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718279975; c=relaxed/simple;
	bh=Nz7WhG+8x7VKvhRppHRObw87wOqKhiEmL5dFA3dx3r0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=L/mEhI3DJz2OhxkVoL5UIHGGx4oU87bgGOaQ2TuV4t7KzONQHsRla2OJz0decjxpPCqjbYNW4UuCAXjfE+15I8RxgI4pi9sM//Wol9ZxpIc209Q21gslEX0DP/pL3iHLvYSAa+LES7UyuUXHhV2SEdolmnzGr5R4ymvJCM07bZs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45DARdSX001326;
	Thu, 13 Jun 2024 11:59:21 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2041.outbound.protection.outlook.com [104.47.73.41])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3ymcgwvwwd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Jun 2024 11:59:21 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A31irUzU6XUcxz6IcN5i5vE0iX1taUR3Qftxjg1zwM4JS/ZCuYNDTJKkWMW8MUfL9J7qlheurbHDkjavL6ZAa1jlFEZ9acEhI2dsbM1bp25d9ntoceByQ8J+seYwK0ReIgf26XJuhytkJnLEI1OLvTlLlwlTLLeCQ+VWQ/AW3p3pOynyhwJCVkFawK5bCN7t2o6/h3Rg/mTHLrWYkwkSQYJepOquGrn3Ap60v8Iw1edCfHcamSjFqy1jaEgAA/duMnh/6alQquDVt58UXjkjIElx2A3+xJdQB9jeS9PqesHHgJV6+vZJk+hI5ridqzM4z/uMtnYJpldSg+1PV4xt7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JxqQRWOHcmDCUVzYzo+yoNv7+XhVPKBXbktjkXJrkvQ=;
 b=UPZ+mjFxQaU52TqtbbPG2mLVaySR+ST5XekiMaEVUK9k8rfWEr1NSECe7aQD8jzR42fdtXcrE25v8FPGpJZISKCj3zRjZoVsbz1ch5UZzfIAYD4ksUt4IWZMvOuiSCupVmku/HiNIjdkzwUyDGeC2dxkApvpbTLNi9mTEUGsSsYpcuLMowLFZ6k27brP6yJjjycxcAO+XkfA6zHPktm9iryaA943H9b4md2fnNpDwQyw3Sp+U/1MLhOf2wyM60GoOOWtAJRIqiYKIM2a7QJBgTRLfxNCjaTNj5gBD30RtHZ+LgtdUU9h58WI78qHSlDgSxpqEanP43teoNBNjTgNuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from PH0PR11MB5191.namprd11.prod.outlook.com (2603:10b6:510:3e::24)
 by DM6PR11MB4753.namprd11.prod.outlook.com (2603:10b6:5:2ac::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.37; Thu, 13 Jun
 2024 11:59:17 +0000
Received: from PH0PR11MB5191.namprd11.prod.outlook.com
 ([fe80::e9d7:7193:8b2b:f0b9]) by PH0PR11MB5191.namprd11.prod.outlook.com
 ([fe80::e9d7:7193:8b2b:f0b9%3]) with mapi id 15.20.7677.019; Thu, 13 Jun 2024
 11:59:17 +0000
From: "Li, Meng" <Meng.Li@windriver.com>
To: Greg KH <gregkh@linuxfoundation.org>
CC: "Thinh.Nguyen@synopsys.com" <Thinh.Nguyen@synopsys.com>,
        "quic_uaggarwa@quicinc.com" <quic_uaggarwa@quicinc.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] usb: dwc3: core: remove lock of otg mode during gadget
 suspend/resume to avoid deadlock
Thread-Topic: [PATCH] usb: dwc3: core: remove lock of otg mode during gadget
 suspend/resume to avoid deadlock
Thread-Index: AQHavWUpPI1owxfhuU+9LSckBbEJwLHFVmIAgAA+/WA=
Date: Thu, 13 Jun 2024 11:59:17 +0000
Message-ID: 
 <PH0PR11MB519103593845FFAA819A92F8F1C12@PH0PR11MB5191.namprd11.prod.outlook.com>
References: <20240613073959.1939608-1-Meng.Li@windriver.com>
 <2024061313-october-sniff-5b0c@gregkh>
In-Reply-To: <2024061313-october-sniff-5b0c@gregkh>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5191:EE_|DM6PR11MB4753:EE_
x-ms-office365-filtering-correlation-id: d87dac6c-2df3-4a0b-5bca-08dc8ba04097
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230034|376008|1800799018|366010|38070700012;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?nGxDfExzXMStpl6XR9UQU4E5ixvB/cK2wiNLShtz0/mvtLLzMqU9Qtq7Kfv9?=
 =?us-ascii?Q?ufANuZbrUMF5o3CLp0pMyHa2jOveyOfPFKW000KNXJEDA3Kor/wY7f3AtQ7s?=
 =?us-ascii?Q?ML9MjN1mD9KNsUtZr1qafe30XQIEHmS6vkcLAyHBq8yqTd2S6wTSNUkjaFHH?=
 =?us-ascii?Q?vITIPfaSVGHiiqkvb2dCjWUGvajAknka6zU3697m2vlMUSseDo3gpUFTFuX0?=
 =?us-ascii?Q?73f7qjHa1sL+V4WRtHbFZGw8T5LKYTktKu1CXJxUGzUu+p27PTmaNayZe8pS?=
 =?us-ascii?Q?lTQyqEpZatVm0v8uXg5DoadX2QcOiFvqm5oBrAgLDNEa+uSrsOz/ypVolO6s?=
 =?us-ascii?Q?OgmUhypVIznQwjz9wXmBwaOHs1hDOJD5zQgZfJMlBexdaDgarowxGj5Cny+L?=
 =?us-ascii?Q?kVfuwcrvlMFEukzRdqL37pvZUGFjRD6ZARj73Bko8RBL984nPhuIs59NairR?=
 =?us-ascii?Q?Oa5ZrteO86ynDbMouGH7ds8//BhSIYlMdxbe1W2gpTRVAVyyF6bbPOHmb/C6?=
 =?us-ascii?Q?twwLVoWgly3ihGkLddoj/P95sF1uBar9kAz4l5qJNgzMkP+ESIBhi8jLIhrT?=
 =?us-ascii?Q?osldvlLV9oRglHmFzU6kZKFhCqnFYgFqKoTGz4tY9p1A2aRTWx+q90+kEdEX?=
 =?us-ascii?Q?oqeqIQmm15ucc+Uy2rE90jO7ngd/JEr1HpbDeJghGAdsVGK/pNSCChdtBHXV?=
 =?us-ascii?Q?SU90xpLWd3zTk1/XCiHRu6WTiYPmhnHelIciTGR6jUCWHJuedbblWZJKl5xQ?=
 =?us-ascii?Q?Ihnqg4mB9kFP4xrRpYZ1DyclGCR294IuybzZ2+Vf4jki7wkA6yy8kZYRW/Rv?=
 =?us-ascii?Q?Q8WYAxUZOyZK2Pkh9Kb3ftMqvmm79ADQBkefogiuZeBldf/cBp8rplPs9bOt?=
 =?us-ascii?Q?pMX6ozZLAK2hi9b675aoiE/32Y98OY9StIhz5dG4hyUAxPwlyDytQh3USNEY?=
 =?us-ascii?Q?32vKrVnSkydgE1HAB7dRy2J0FSRjbv3FyGpZ3emH6/nSrm51Uhwx3/jK2bhz?=
 =?us-ascii?Q?XfIFn7ByJ/mqQed5WHcqmCzr8rDkVLeGPrv7YF3+fImHQEC1uGHEPYwdRc5B?=
 =?us-ascii?Q?wOHBLbyG1cIqljlnSqkc5cnAP4fmreI1jo2U444KdOp9N6u2EAG3A5aVnV2U?=
 =?us-ascii?Q?ejI9WAC0zhr3iI2efo78nuWfU6+Hsm5BIrx8sAhSH904r4jHsE9OEEx6kBXW?=
 =?us-ascii?Q?xw8wLphAMKSorAviqnFb2WY+MbgcKwFUevUCky9Jibf+aFS6Op/MRedfl7T/?=
 =?us-ascii?Q?M68RAWxzBFKBHVUkbSFP6TpiLMu1WKty5RtqJc+wieT8vIqnCbUeiSijralX?=
 =?us-ascii?Q?MaxJ1pAS1w9gStrI4Wt/met91Xmuc0GyoweU4iw5Yf0ETooMuL2Fe5/1o5hf?=
 =?us-ascii?Q?bd1fu98=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5191.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230034)(376008)(1800799018)(366010)(38070700012);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?FItqdAkz7xe3FhKgzuqseXPB/vkHNhrskrV4UmpMhrLSd6SgdqEmRhV3c5fp?=
 =?us-ascii?Q?e6W8ytJnWj2OuwF809p8sVZrn1dnoixoa1aO3xSZpTIxX5ai0lCx94WmE6Nl?=
 =?us-ascii?Q?SiaRzakTl0e+V0ZQdmk47F31KkXM+AdFFAEfxzoOOSsY2tr3yIU8PIWS+YF1?=
 =?us-ascii?Q?WMIOrq4ch1bWrO9RxwjoCnThbU8zlSO+SayctPqSRAVI+YDNVY1sAWrEPyaK?=
 =?us-ascii?Q?WSpWbqVp/LF/s1PmTSM3rfkyLTjtHMdyQ+R7SHWM0yN8S1m8Q9GHbi9Uf5QK?=
 =?us-ascii?Q?nFpma/+u9wObpxZ8qjHanJTqhjmB1yOVigIwpPUkR8R7go0/M9EyokPrSrXL?=
 =?us-ascii?Q?mqCkSBDZNMpfPdrtf3KgPukHr7v1gp5IU3WgVgLm6fT81J/ZXF+HbhcOUi1x?=
 =?us-ascii?Q?zNgOhceXM6XWniflK6CwkKLUtHStIvV/SamKy/KonLVtGTtfaC1R3q+p5bP4?=
 =?us-ascii?Q?HmyjGixc6qMGUMrzXt8QwNfB/ocZ2n1NRfOTkCQk5rSC1POtsxtrSZuj0v6W?=
 =?us-ascii?Q?J6HWxrb7Z3gyDG870lWd/3htKZz3c5oYm9ds4wRc1bRXPOqWn/cK5PgnE0Au?=
 =?us-ascii?Q?w+ULJkKXe06pVv73Ema9lJXOyLi69t83pnJrxZiJc+EJ695Erkby/rJ4PCUl?=
 =?us-ascii?Q?7r0K7UTREfr3MAxj0EJQ2JqG6SRzYXjhFgklikj1IdzHHe8wvlvV7Tjf4Dhn?=
 =?us-ascii?Q?2AxG16FDUY7y/uVE2upUoTWb4beI+yDtIzciVdEgFYHGkYgLQma03XaAs8TN?=
 =?us-ascii?Q?oST81+pHq+1HxcKdVu/6S9um+nibIVRZvoyahAL95ig2+oz8QNCsdRz/JNvF?=
 =?us-ascii?Q?ZlFZGZKb8QNZIYybBaNctJahSWLzQ1h8CmB4yRO33T5Mi3sEB8d6GG4/yXem?=
 =?us-ascii?Q?RKwJPl4tsx23QkecAcAVbhunxHhGtQMRi654poYl8Mruovw7VIb2EHf9jfsg?=
 =?us-ascii?Q?s/4fM9QNLlcArH/gdO5uyNVFQmbo0jcTYhFCrLleVqfyXwXfHV4xhwugfIrm?=
 =?us-ascii?Q?/8fMPQ+ef2cW9u82Z5KpfOKwbeBdiIwSA6LXbil9Tk9/Vh04ByRExhpnHZJj?=
 =?us-ascii?Q?MenXPZRKYyXpbSRb/ZN/Yi3zJJn1l8F/A3D6+BHkZxHy7yo1grbJFQALED4B?=
 =?us-ascii?Q?NmSYra3M3iSvJfAzUAqM69Z7nTfBzP3gpN+O3clziZGKnJeZYGTABZ5CX5HQ?=
 =?us-ascii?Q?MZ2tU0eF4nZCuOjcVZefxtVdIUeG0C1gZ6L78TLeZpxl2ASvtt8ENtGLa/1S?=
 =?us-ascii?Q?WD24rS8XBNNr627Qbsy+jxwZt8VrdczsaNTIDLs5ycGABN/v+I7qXkpz5Ma5?=
 =?us-ascii?Q?03VW1nEncOHKM+l5qGhHPMRQsBDj/28fuBp8MdEmziiz6P6/0XRvDEquj3GV?=
 =?us-ascii?Q?2fVailDH3WYUim5KmbPh0BIOU2oRMjaohS+dIn4s+i7upJJ24HBeZrnXcbkf?=
 =?us-ascii?Q?heYVQpQ3zeOfI7EITBkaYw3lqx22do6/MZZklY+oKSbUI0BWB41NKPfePl54?=
 =?us-ascii?Q?wr5AT451OXOkLSiqy7rAPihqfOf5+U/1usJVXAhqjf0IdChCAmVW5XEwHzxA?=
 =?us-ascii?Q?/JNSIWDBze0yIyBb+/ZC04PsQxZ0olH160V4e4RP?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5191.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d87dac6c-2df3-4a0b-5bca-08dc8ba04097
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2024 11:59:17.4235
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ft27JpxUDIf7fL53/ZS2Iq3TsrJnGNEZl5dwc66CJ1umGV0KHNtfpUrhxGhZDIBirrNADmbSfg9asCoHL6pRwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4753
X-Proofpoint-GUID: h20i_Lmky3MStjsmGHP4cPd-8F9XjqcG
X-Proofpoint-ORIG-GUID: h20i_Lmky3MStjsmGHP4cPd-8F9XjqcG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-13_04,2024-06-13_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 malwarescore=0 clxscore=1015 priorityscore=1501
 phishscore=0 bulkscore=0 spamscore=0 mlxlogscore=999 lowpriorityscore=0
 mlxscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.21.0-2405170001 definitions=main-2406130085



> -----Original Message-----
> From: Greg KH <gregkh@linuxfoundation.org>
> Sent: Thursday, June 13, 2024 4:06 PM
> To: Li, Meng <Meng.Li@windriver.com>
> Cc: Thinh.Nguyen@synopsys.com; quic_uaggarwa@quicinc.com; linux-
> usb@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH] usb: dwc3: core: remove lock of otg mode during gadg=
et
> suspend/resume to avoid deadlock
>=20
> CAUTION: This email comes from a non Wind River email account!
> Do not click links or open attachments unless you recognize the sender an=
d
> know the content is safe.
>=20
> On Thu, Jun 13, 2024 at 03:39:59PM +0800, Meng Li wrote:
> > When config CONFIG_USB_DWC3_DUAL_ROLE is selected, and trigger
> system
> > to enter suspend status with below command:
> > echo mem > /sys/power/state
> > There will be a deadlock issue occurring. Because
> > dwc3_gadget_suspend() also try to get the lock again when previous
> > invoked dwc3_suspend_common() has got the lock . This issue is introduc=
ed
> by commit c7ebd8149ee5 ("usb: dwc3:
> > gadget: Fix NULL pointer dereference in dwc3_gadget_suspend") that
> > removes the code of checking whether dwc->gadget_driver is NULL or
> > not. It causes the following code is executed and deadlock occurs when
> trying to get the spinlock.
> > To fix the deadlock issue, refer to commit 5265397f9442("usb: dwc3:
> > Remove
> > DWC3 locking during gadget suspend/resume"), remove lock of otg mode
> > during gadget suspend/resume.
> >
> > Fixes: 61a348857e86 ("Fix NULL pointer dereference in
> > dwc3_gadget_suspend")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Meng Li <Meng.Li@windriver.com>
> > ---
> >  drivers/usb/dwc3/core.c | 6 ------
> >  1 file changed, 6 deletions(-)
> >
> > diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c index
> > 7ee61a89520b..9d47c3aa5777 100644
> > --- a/drivers/usb/dwc3/core.c
> > +++ b/drivers/usb/dwc3/core.c
> > @@ -2250,7 +2250,6 @@ static int dwc3_core_init_for_resume(struct
> dwc3
> > *dwc)
> >
> >  static int dwc3_suspend_common(struct dwc3 *dwc, pm_message_t msg)
> {
> > -     unsigned long   flags;
> >       u32 reg;
> >       int i;
> >
> > @@ -2293,9 +2292,7 @@ static int dwc3_suspend_common(struct dwc3
> *dwc, pm_message_t msg)
> >                       break;
> >
> >               if (dwc->current_otg_role =3D=3D DWC3_OTG_ROLE_DEVICE) {
> > -                     spin_lock_irqsave(&dwc->lock, flags);
> >                       dwc3_gadget_suspend(dwc);
> > -                     spin_unlock_irqrestore(&dwc->lock, flags);
> >                       synchronize_irq(dwc->irq_gadget);
> >               }
> >
> > @@ -2312,7 +2309,6 @@ static int dwc3_suspend_common(struct dwc3
> *dwc,
> > pm_message_t msg)
> >
> >  static int dwc3_resume_common(struct dwc3 *dwc, pm_message_t msg)  {
> > -     unsigned long   flags;
> >       int             ret;
> >       u32             reg;
> >       int             i;
> > @@ -2366,9 +2362,7 @@ static int dwc3_resume_common(struct dwc3
> *dwc, pm_message_t msg)
> >               if (dwc->current_otg_role =3D=3D DWC3_OTG_ROLE_HOST) {
> >                       dwc3_otg_host_init(dwc);
> >               } else if (dwc->current_otg_role =3D=3D DWC3_OTG_ROLE_DEV=
ICE) {
> > -                     spin_lock_irqsave(&dwc->lock, flags);
> >                       dwc3_gadget_resume(dwc);
> > -                     spin_unlock_irqrestore(&dwc->lock, flags);
> >               }
> >
> >               break;
> > --
> > 2.34.1
> >
> >
>=20
> Hi,
>=20
> This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him =
a
> patch that has triggered this response.  He used to manually respond to t=
hese
> common problems, but in order to save his sanity (he kept writing the sam=
e
> thing over and over, yet to different people), I was created.  Hopefully =
you will
> not take offence and will fix the problem in your patch and resubmit it s=
o that
> it can be accepted into the Linux kernel tree.
>=20
> You are receiving this message because of the following common error(s) a=
s
> indicated below:
>=20
> - This looks like a new version of a previously submitted patch, but you
>   did not list below the --- line any changes from the previous version.
>   Please read the section entitled "The canonical patch format" in the
>   kernel file, Documentation/process/submitting-patches.rst for what
>   needs to be done here to properly describe this.
>=20
> If you wish to discuss this problem further, or you have questions about =
how
> to resolve this issue, please feel free to respond to this email and Greg=
 will
> reply once he has dug out from the pending patches received from other
> developers.
>=20

Sorry! I sent the patch of linux-stable version firstly, and then I realize=
 my fault, so send a correct version for mainline upstream.
So, I think I received this email from patch-bot to remind me to add the --=
- for change log.
Let me clarify that this patch is the first version for mainline upstream. =
And please ignore the previous wrong one for linux-stable.

Best Regards,
Meng

> thanks,
>=20
> greg k-h's patch email bot

