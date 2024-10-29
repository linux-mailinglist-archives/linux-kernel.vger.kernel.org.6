Return-Path: <linux-kernel+bounces-387723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FDBA9B5558
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 22:53:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 939771F23F54
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 21:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5856C209673;
	Tue, 29 Oct 2024 21:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jqXr3w/M";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="zKAoxwhM"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B041422AB
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 21:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730238811; cv=fail; b=rBwUPHJDIj7sYCU7Y82rgrWWtGxJmZPRw94EXWwITXYkTy54Oc4SeVZC/bYKe01rkIf1uW6hQw7UGgtUmH9QbP2x31THZRIicuOgRJ1qrkMVblaicVu2LAbmqReeiB13txaC3ihwA2CEoAMJeC2lK32KlH3Uqhk3oJGG0ifJdy4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730238811; c=relaxed/simple;
	bh=Tqad6gdkmA9kq4aY8JCLrOnr/DEMa0W1GQFFgy3zMyI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ebAgjqf0BGriZcYt5t9qegfg0YTyN/+U5sc8qS5frO+os2BdQrADZv7PcrZdteGqhKShGEEuYBkbV6HF17vggnXYaTnSnHhZ87deYiao/UZ9j94z0lUEsakbUsuzH6YocJseAceg37t3q9cBDDPocAcNx6b6IvcxXfTWBZcpHgs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jqXr3w/M; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=zKAoxwhM; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49TGfZUD028594;
	Tue, 29 Oct 2024 21:53:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=Ix5cazGtnFQelzIzroUuv7J+wmT/B5fO+mXd3XVmB4E=; b=
	jqXr3w/MrcLm09BqnYBmvV8To5/cSNZzjlAsnNGkamQNqvnZTMnm/eCbnoOIS8ms
	EYBRqStnmaaSoTuRKiYOLdOA7lzkGctXkn8Tn/6XNZpR8RoM6uXEXQAEQ+JB40dR
	ce3mwr0pYunMZT1+VgzoOLwe9GSCS3VoSjirYEC4suLjj2x0Jcio07zyGN6oYnkP
	m6hHk0x1r2NtH9nglhRLdK2TuEW55q9M+9riODq5LpLkp1enicDMN9E2y+uZLgPZ
	VHBwbcTaCbY0pVqTVW08BYU7Vf1477/yL6VFX2ktNkpPrZWTxc1LtxOHWOT6LjJ/
	BfrHYOUr8sH76rkLjk9FtA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42grdqem93-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Oct 2024 21:53:10 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49TK0R10004789;
	Tue, 29 Oct 2024 21:53:09 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2040.outbound.protection.outlook.com [104.47.74.40])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42jb2uw7j2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Oct 2024 21:53:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cYNxrq+h09P1wOWNH9UlrF1VXmqedM9ljROoxD1/pjShnBQPZ43+aSi0JtWHy95yT89ZvdSeb22VwPZIFd8zAcuCe4ILf4z87bObNl6dHM90gMsDLstC1D934JMufcPl2CA9m31UOWfLQohgIKueR5cbVOuLeTo6eI1Z1E56826ivp6haXa3Xwn0qgPPZxZUBYB1mRhJdSx64o5INdcmLWvZu5e0jcirR5oh+ZBSnN/X5SBCnDfKUEKvR3MLGmKUpYd1GO0GaN1jPDHsrVTWXUAs1Jm2GKdiUKVSuI+Nfl5RynRtn1y+WYitdj5Z9gqejGQummxit7ZGayG8Q3FFkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ix5cazGtnFQelzIzroUuv7J+wmT/B5fO+mXd3XVmB4E=;
 b=tO5OLxnbZTayTcd7kZnOzXpZFStO1cxPJA1cq3+uRNvoicBhMifj2WK8liYWMr24AHCVaNmMAFDg6sKVREhZh7PqU80SGMo2GzYOozdgQsN1/8xa63g6IZGCT16v42i0Vhm8G6HvIVASLghBWU82fHxjoBXyjMfMKRBaiiYWtJFG0hH4rsp50O20Y6zlNWfzORWUSIAzMRR+gM+Uc5Eehl7Nbkycld2KlAnIIl/8SanLetlOiaHX8M8GtBb0wZ85u9KAIlhtSP/DCS6FxdGhWrdZf9690Oq06A02isw1/V0RgnPKSf0vDGIhcoBl7EWk7FTlH6sVJui6sFIQ4DK5BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ix5cazGtnFQelzIzroUuv7J+wmT/B5fO+mXd3XVmB4E=;
 b=zKAoxwhMeh6D+3nK6dclnnZFATH3vUcssPiJsxN99BPh7lvaYvWQaTALnESuZw1nwGOyJSM27UWS0FdQa+g+tWcmd5utayOc/Kdm/T4hq0vq/LFlHkxawX+YGrFRPFrA3YqOiHDBrT68BGopCbXKrv04BrUrOVitAYUbVHxjI/w=
Received: from MW5PR10MB5738.namprd10.prod.outlook.com (2603:10b6:303:19b::14)
 by SJ0PR10MB4622.namprd10.prod.outlook.com (2603:10b6:a03:2d6::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Tue, 29 Oct
 2024 21:53:06 +0000
Received: from MW5PR10MB5738.namprd10.prod.outlook.com
 ([fe80::187b:b241:398b:50eb]) by MW5PR10MB5738.namprd10.prod.outlook.com
 ([fe80::187b:b241:398b:50eb%5]) with mapi id 15.20.8114.015; Tue, 29 Oct 2024
 21:53:06 +0000
Message-ID: <27591dea-ba0b-4193-9335-680aa96441ef@oracle.com>
Date: Tue, 29 Oct 2024 16:53:04 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] jfs: fix shift-out-of-bounds in dbSplit
To: Ghanshyam Agrawal <ghanshyam1898@gmail.com>, ghandatmanas@gmail.com,
        juntong.deng@outlook.com, aha310510@gmail.com, peili.dev@gmail.com,
        eadavis@qq.com
Cc: jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        syzbot+b5ca8a249162c4b9a7d0@syzkaller.appspotmail.com
References: <20240930081218.2992648-1-ghanshyam1898@gmail.com>
Content-Language: en-US
From: Dave Kleikamp <dave.kleikamp@oracle.com>
In-Reply-To: <20240930081218.2992648-1-ghanshyam1898@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH5PR02CA0015.namprd02.prod.outlook.com
 (2603:10b6:610:1ed::9) To MW5PR10MB5738.namprd10.prod.outlook.com
 (2603:10b6:303:19b::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR10MB5738:EE_|SJ0PR10MB4622:EE_
X-MS-Office365-Filtering-Correlation-Id: fdcab92b-8f37-4bde-b02d-08dcf8641204
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eHlTbUdycUlyMU9menl2SXJWNy9UcFhTeDFRTEdQZHVuWlZLOWJDRFdyRHhz?=
 =?utf-8?B?WVNKMC9TRXZyVDhiRDBid2hwOGQyNEVpNmFGSzBhYmtKNzl4S3gxK1JRd3JK?=
 =?utf-8?B?SzR5NXRaRGpzeE1iVWdSSzUrOXhhUEF0dEMrTjhxWEE2VXA2Wlo4YkVsN1hJ?=
 =?utf-8?B?RC83WnJOeXk1NjVKbTY0NWowR2craWtFOEhCSXhDYUhRcmFhMmNUWExtS1Iy?=
 =?utf-8?B?WGZnTER3RDB6VWFnTnlyeVpRblF3NlRxL0YwTmRWMU1tK0J6dlQ1S2Q1Z1d3?=
 =?utf-8?B?cTJqVmpEbFphY29scVBLZWRRbjdEd0VTcFExM0x1b29makRWUE41UVNiekRY?=
 =?utf-8?B?aUNsaUtvZWFEVlNPOC9ySFhnbGxibmJ2OTd2QWVRZ0xZc0g1ZnlJM2dzN3RO?=
 =?utf-8?B?OEk4U0JxUFpJQk9PSG1lK1M5azYyejVJdmcvVVMvQk5uWUtybkZnMTllbzk1?=
 =?utf-8?B?SVpzRDRLYjYyOFdtWjJycklYbFh4OFR2NTIxOUY5ZWJPTTRGM3FQUW9HZ05a?=
 =?utf-8?B?bWphaDg1WE9waVExYWZBUSsrRXdVS3VteEZJcjlMZFlJcTFKSHdMTmY3ZGhq?=
 =?utf-8?B?SnU1OW1vdENjVU5lZ2Zsd2hRRlBvS3ZjNHdraFBISnF4MFRQU3RnT0xpQU11?=
 =?utf-8?B?eVRNelhlSWlaKzZhNVh4cDR5UXhhU1B2ZG1WT0Q4UVMwN3lFamQvdFdweFFE?=
 =?utf-8?B?My9oT1dLVCtKTmFISkVrWnRPL3Fhamd5eTlpTGlXTHVuT0tvN2dVbzgzSWxQ?=
 =?utf-8?B?ZFV5TjZPdVlEeDhuellyd0xCN3JwKzdVcitVSEtxY2c0NmtJVEF4QXp2cUp2?=
 =?utf-8?B?d3VkcnU0cjJzcFNEdGtSRGNDSkhpLzVpUUU4VFVZRVAwVHlTekxER0s4Umsw?=
 =?utf-8?B?L1RLVC9Odjg0QW02WGVtL0xkcmV5bDQvWXRWOG1ZUk0zU1ZselBldkplbXNp?=
 =?utf-8?B?ZEpQaVo3bmhkSzNOckFTMWFMSk5Dbk5ZeDRNTURlLzM4OXFyZDcrWDRJamlx?=
 =?utf-8?B?aTFlWVVCY2cxSTRUV1pGN0tJckplakZ4WHZQZ0lhd1JDSlBwenpjbDJZU1Bl?=
 =?utf-8?B?RExwRjkyaUNoL0hTNmd4bFZCWGlydnQwcmFMcDBPRktXS0FBYjJuM1BJeTla?=
 =?utf-8?B?QUlxRGdzZFY3L2ovUjJkaVNvZWl2aW9ESW43L2FJVkNyaFZiekZBRDZtYkx4?=
 =?utf-8?B?QkNOU1pIZlpPdjRBb21DdGdTN2xCcTFsNkN2U1M5Q0o2SlMvUnNQalhYN0ht?=
 =?utf-8?B?QW5ZYW8rVUpCUFB0Q3RwWXk1bjVlVXJqZjNUTEU0ZlVsN2duWmFYakZUNE1E?=
 =?utf-8?B?S0JzbUpoYjlhc0FLdHhrVzJGRmhUekxUMGZINllERmRtOHZRR1Q1M3FhQXAv?=
 =?utf-8?B?clI3eHA5b2VMZWM0RTF6akcrVjIzenZMaU1WdHJvY2JuZ09scGZ2eVE5TENs?=
 =?utf-8?B?dXI2L25PMFM0Yjh0c2p4OXZVL0FIdEhScW9HbW1zM0p3YzI4VmtjWXF2YzJ1?=
 =?utf-8?B?UUtCTTVGMnZPcExoc3diVi9CbG1rdnVRalJnc3VpTmpNUXFzcWFEWnlabzkv?=
 =?utf-8?B?UVVkR1hEMm5aSDBFNkFlUmJIV1hRZGlCaUszYUxUWjN0R3ZUUnhXc2N3ZG9w?=
 =?utf-8?B?UzltSFRuVVVVOXdCQTlEOWp5SWJ4ZzdjN01DdlpxZmVlKzJMNlBpK3JySTE4?=
 =?utf-8?Q?doeYz6FXtbpEFojuctrH?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR10MB5738.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?elNSSUVwcmhXY3FYc2Q0RVQybGFnRmtpcThEOXVDV2ZNc2Jyb3hKSjRWdXlE?=
 =?utf-8?B?VS9lMzBCb1FwMy9QenYwL3ltYzdZc1lMMGNrdDlZVno2QXVyaFp6Y21WUjZ6?=
 =?utf-8?B?YVFkajdIUk9DNGxKV0xNeU9GUmZjcW54akIvZlJPK2xtNVVYd2Y5QTk0MHZm?=
 =?utf-8?B?Y1FCa2dtb1ZrRXBlVDhTQjhIVDU3M2dXSWZyQnZoYzVHUUNjRzdZbUZhSC9N?=
 =?utf-8?B?cEUydWtnNFZQY1l1MEdNYi8vdXdJUUNNY0RUdmRXSm5HQWt1cVlWWXhkU1B3?=
 =?utf-8?B?bFMwSUdyby9IaisvMFg1UHZYU2lJSlF4aDRRMGRkam5mTkZXaFJOMCtLd0kx?=
 =?utf-8?B?YUFSN0ZoZ1BodXNWSGw3R3BSK1NNSW1vdy9rSVZhV3E5a05SQkNZaERmMjNj?=
 =?utf-8?B?RXdaUEFMem41M0IvZDlaY3BGbmNtT0VtYmV5ZE1RRXora1hoN3BueEtHWEND?=
 =?utf-8?B?c1VnUWo1clhYY1FmSjV3UTU0cThXcUNRZEpCMlVPeGkxdSt3dlBsbE9WRDBC?=
 =?utf-8?B?dGFWOFFnRUYzMEEyN2ovd1RKVFNjZFlseDA3cUFZZ0RtKzQvYXdkK3ZUUjJ0?=
 =?utf-8?B?cUY1VWpSdGFrRlpOMTVibnJzUkZwWU8zWHVKYWJZdHo2L0YwclEyeldWZUQ2?=
 =?utf-8?B?V2JPb0pmeW9oam1aendQa2NncGtSZTRISVd2MS81bVU5cjIxMk00V3BqOEZC?=
 =?utf-8?B?c1Z3VUcwU2o5cWk3TkZXa0ZPNVNwZkdlTnNjUnF1RHBySytRZW9saHVKWlR6?=
 =?utf-8?B?SXpBWkdMNElpMnpPRVhOdHVEa1N3Sjd6cGFHUktwdkR2Nm8vQ3c4cTFUbUk0?=
 =?utf-8?B?SlRTSS8rMGZwQXlpRHlyVm1XcGlQRDZ3bG5WYmFwUVVrTzhQb0crZkpNY1E3?=
 =?utf-8?B?N3NMdzFhOVg3T0g4ZlB1dGpZdHUxRVRQYWF2Q0FzRGJMalFWRUs2c3UwUjM0?=
 =?utf-8?B?V0RFSGFHSFptVk5VdnJtNkE0dFZMSk1VR0tUM1pWeUE3OEIvN2YwNTZ0ZGR5?=
 =?utf-8?B?YkJvVWdLSzNaNEV2SDEzY3I1YVhkcHNxME5jU1NWWmZOMmJXQ0RBbDBTdnZ1?=
 =?utf-8?B?cmRiWFpZbWZ4Yko3Q3JBWStieTFQWXZYMFEralBWNUFKbG1Ma2pNcUMwRUdV?=
 =?utf-8?B?ZHZNa2JMcUtIcm9hZzRkK0pMU2NqVGh1RHVvQzFnL2pQVEhjNEZFdlh3cWYy?=
 =?utf-8?B?a2NUNEVmKzdLMVNRemVBakorMG1RdXlIdkpJNXA4M2F0Z1BLMjhBTXJGY05G?=
 =?utf-8?B?cWFuK21KYWplRVBxbU84WXpGSjJaZURaZU0wd0l1SytxOFpGTnBucTVUdXBS?=
 =?utf-8?B?YVBXY1M2elVpSUVNL3drQk5renFydmJKVis1am9OWWM1UDFFejJqR2hDLzdq?=
 =?utf-8?B?YUltRTBNYzFFb1ZSV29aZ2tUS1RSa1BSYzA3bGpQSCtSYlJmbUxMMXR4dkYr?=
 =?utf-8?B?eWZCaHYzVlAxYnJTNFUwZUtqN3UzYU4vVmw1RzR0MStVdnlwQzhkOGZwNTBl?=
 =?utf-8?B?OFZvQjlVWEVJb0dUZDZ1enV1ekszSW9uazBHdzZUSkRFSERkNGtBcFNITm1Y?=
 =?utf-8?B?eThQbFRGZXp3ZTNYbHZUY2ZoNHFUbHpCbXBYa2psSWhBblJlbmcwYStRY0U3?=
 =?utf-8?B?K3Z6aTllN3pSVGdESWh4MWVpQ0luRkNINWh2UFRBSGJ1bHhZSTg3VUlsVTNT?=
 =?utf-8?B?QVNKQWQ0b2h2RTJzbEN4Y1ltWFNVSk9DakV4OVJhNm5teE52ZTRYOGRlOFdi?=
 =?utf-8?B?dEExajFaRWJhYXBtdGlJR2N4ZTY4eldJd210TCtBQWZ1d2VqbmxNcThkYnVL?=
 =?utf-8?B?ZytXUHV4WE1tamMvRUEzRTNiSjJjMWQxd0FQT1o2aW5YcXRpaHJDYWRIalZ6?=
 =?utf-8?B?cXVTaTF4by9tUEMwYXltVXVVZXJXejg1ZHNRby9jd05yRGorTzFEclNYVVZZ?=
 =?utf-8?B?blVBQTBQZUdqVnZrRmtUOU1Ib0hDV2UrRlp4cTBTNjdXZWgvbEdIVCtMdmNl?=
 =?utf-8?B?TFlOcUFxd0ZLbjl1S2ZRWnZ0NXlnSUorclZxQ3U0NFJsY0k2dElUdHpYZmJH?=
 =?utf-8?B?Z3Z3Wm5rSVcrMXUwTGlhSUV3TUw3Y2pqSkZ5UWhNbTdHQzJYNmxmYmJ1N1k4?=
 =?utf-8?B?Yy9aNnB2WTIxNi85d0NpSnZYbWxKY3RIZjBKdWQrcVM2UFhUQzIybjkxZ096?=
 =?utf-8?B?RUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	+s+OU/SWZQCVsBG9p+8Y3ll2emHhJRaYcONeFhKC9IOrOWecUBUsGcvCwif3PxppxA6mYeQjf+Nj0XmLGPK72NggZzgVmb2v5f5M53trUUSGkpDNxLAyyLW3tDUwjCJyHtWtXbZg52YT87q/8OxZ/TRXaiZ4uNApRwgXGMAqXTfqJxmhDTcYoHMgLQ8UpywAT9nzlZ0ywep9z9zJ+7Q1vBRJN3z1UMJT67Vwg+YeWmGhRbG6J73xDMiihL0gGYLdRXLTDcTphRQ+3fpGl5yAYYai9g1heYIxTJAhUFemiDhyI1dpceCY3VwY0VSxqtcFCb9SiY9hPKRkBY4LCOhvGnDB4HYYlcpjC98POFM3WaPiApwaOJO/K3cf5IGPOyIaWy0EtT+sjRjmrntUmItx+GPbI+n5y2SlDYNFf6yEjkFRp+se5JJG0PSVawp8aEm1yRh6wN8qmTUV3GUbgA69iloJFEyRApZ3JAbjYuqSxmmGKso8YAFboG//3B9w1VtxVtUhZp7m0/rogFsVebXEEjoMfXK9Ek3B2rvNsfzU5Z43rlf3nE7bISsT5g0noQov1+umBr/jt/+9kubRRV4OaROcZ0iOZfJneKsOa6to6hk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdcab92b-8f37-4bde-b02d-08dcf8641204
X-MS-Exchange-CrossTenant-AuthSource: MW5PR10MB5738.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 21:53:06.4123
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kbNl70JJfpS1zWiJM6Iy3t1ev/YqxH3+xL49TPsfRHXOzwtERlICDg3WvDe7x6wyXKMh5Fn7l0FwEg9iNGzzu9+fsbFz+qZcQRa0Oujrkgs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4622
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-29_16,2024-10-29_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 bulkscore=0
 adultscore=0 phishscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410290164
X-Proofpoint-GUID: syheQCpm3xyVY2MwmOiWcx39Z8JMt2Ob
X-Proofpoint-ORIG-GUID: syheQCpm3xyVY2MwmOiWcx39Z8JMt2Ob

On 9/30/24 3:12AM, Ghanshyam Agrawal wrote:
> When dmt_budmin is less than zero, it causes errors
> in the later stages. Added a check to return an error beforehand
> in dbAllocCtl itself.
> 
> Reported-by: syzbot+b5ca8a249162c4b9a7d0@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=b5ca8a249162c4b9a7d0
> Signed-off-by: Ghanshyam Agrawal <ghanshyam1898@gmail.com>
> ---
>   fs/jfs/jfs_dmap.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/fs/jfs/jfs_dmap.c b/fs/jfs/jfs_dmap.c
> index 974ecf5e0d95..f65a07252c22 100644
> --- a/fs/jfs/jfs_dmap.c
> +++ b/fs/jfs/jfs_dmap.c
> @@ -1808,6 +1808,7 @@ dbAllocCtl(struct bmap * bmp, s64 nblocks, int l2nb, s64 blkno, s64 * results)
>   	s64 b, lblkno, n;
>   	struct metapage *mp;
>   	struct dmap *dp;
> +	dmtree_t *tp;
>   
>   	/* check if the allocation request is confined to a single dmap.
>   	 */
> @@ -1819,6 +1820,10 @@ dbAllocCtl(struct bmap * bmp, s64 nblocks, int l2nb, s64 blkno, s64 * results)
>   		if (mp == NULL)
>   			return -EIO;
>   		dp = (struct dmap *) mp->data;
> +		tp = (dmtree_t *) &dp->tree;
> +
> +		if (tp->dmt_budmin < 0)
> +			return -EIO;

I'm simplifying this to:

		if (dp->tree.budmin < 0)
			return -EIO;
>   
>   		/* try to allocate the blocks.
>   		 */

Other than that. It looks good. I'll apply it.

Shaggy

