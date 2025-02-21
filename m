Return-Path: <linux-kernel+bounces-526385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BA14A3FE0B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 18:58:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5FEFB7A5CCF
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 17:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5ED5250BF1;
	Fri, 21 Feb 2025 17:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="zwx4LdfZ"
Received: from ms11p00im-qufo17281701.me.com (ms11p00im-qufo17281701.me.com [17.58.38.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2104736AF5
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 17:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.38.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740160682; cv=none; b=K7yHSUasi0wtDkq0jmMFPGGOW9n4k3AqUEa0TonFlNJYxEnYUubogkgVpR/BSFhVNcs5UXf4jxtIPOq8KMVqMZb+85fcAJ7oPDbHe0++XVrZc8RFPKJanw6J5LIihCSPqCO9Jnlhdg6lEZW5j5T2wDAjinvyHyYMq403Vo90a94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740160682; c=relaxed/simple;
	bh=op+z/cIIie55JRr2ZdyXga9BoeNWSol3HKlp/UIjd74=;
	h=Content-Type:From:Mime-Version:Date:Subject:Message-Id:Cc:To; b=I5/+8/uWnFcMiWOi+K2vsZBKJi7L09eXUF2anRJgW3ncFK/YsCUWfdI1CIZ8+aI8wCbNnkVVBsdgqXUJYVAT70hcLsFthCNlKKe1IjPkvDas9n4H8Z4dhzrGGMyeE1WIdJemAYZFWQREq/Yg3lZZ1QnZ8YKHYhCLlR9vnpjuxM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=zwx4LdfZ; arc=none smtp.client-ip=17.58.38.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; bh=op+z/cIIie55JRr2ZdyXga9BoeNWSol3HKlp/UIjd74=;
	h=Content-Type:From:Mime-Version:Date:Subject:Message-Id:To:x-icloud-hme;
	b=zwx4LdfZXiyiyXW9vd8Bb62j1zckTHTjL0S4t1FMKhB+RyNH3m1po89lD/n7Ic2OK
	 HQa6CnuWoEcOTKErjMJNrSr+obffB6f2L58HYCsY3T12pKdnzKO2X0Poo1tjaSP8s7
	 22bJJnBptZRY/4cBc9Jt1zKORziRSAPwJdVz1s19zI/LtVPFqDq+58ngrVCA09Ad8b
	 OoqzkM969hu3P4dQw3PiqTrDcVj71DJVODwNhY5lYPC7brGxGcrRBA+PRt90zt/bDH
	 N7aDLBtxQyw3Ja1X4drcl8+CyNCOQqYYY+sqX6UqACNVfUnnT5oXOYY1o/h7uI9ov5
	 AWd805155r76A==
Received: from smtpclient.apple (ms11p00im-dlb-asmtpmailmevip.me.com [17.57.154.19])
	by ms11p00im-qufo17281701.me.com (Postfix) with ESMTPSA id 14BA4742536;
	Fri, 21 Feb 2025 17:57:56 +0000 (UTC)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: MICHAEL TURNER <kameronwayneturner@icloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Date: Fri, 21 Feb 2025 11:50:03 -0600
Subject: Re: [PATCH v14 0/8] Rust support for mm_struct, vm_area_struct, and mmap
Message-Id: <4E4C07FE-95F2-4EF5-BC54-DA407E6EA85D@icloud.com>
Cc: Liam.Howlett@oracle.com, a.hindborg@kernel.org,
 akpm@linux-foundation.org, alex.gaynor@gmail.com, aliceryhl@google.com,
 arnd@arndb.de, balbirs@nvidia.com, benno.lossin@proton.me,
 bjorn3_gh@protonmail.com, boqun.feng@gmail.com, gary@garyguo.net,
 gregkh@linuxfoundation.org, jannh@google.com, jhubbard@nvidia.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, lorenzo.stoakes@oracle.com,
 ojeda@kernel.org, rust-for-linux@vger.kernel.org, surenb@google.com,
 tmgross@umich.edu, vbabka@suse.cz, willy@infradead.org
To: miguel.ojeda.sandonis@gmail.com
X-Mailer: iPhone Mail (22D72)
X-Proofpoint-GUID: et-UK1u--jyUWGHag8IkCXngVwsWgwIv
X-Proofpoint-ORIG-GUID: et-UK1u--jyUWGHag8IkCXngVwsWgwIv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-21_05,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0
 mlxlogscore=770 suspectscore=0 bulkscore=0 clxscore=1011 phishscore=0
 malwarescore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2502210125

Please uninstall VM
Sent from my iPhone

