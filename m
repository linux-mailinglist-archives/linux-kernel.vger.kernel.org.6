Return-Path: <linux-kernel+bounces-430441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CB3B9E30E4
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 02:44:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA143B2777E
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 01:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09C6E171CD;
	Wed,  4 Dec 2024 01:43:51 +0000 (UTC)
Received: from mxde.zte.com.cn (mxde.zte.com.cn [209.9.37.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 454C217C61;
	Wed,  4 Dec 2024 01:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.9.37.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733276630; cv=none; b=DE//+e6on12jx3l0K6lJj3ZtH2LnLpuUod02b0JPNgjIyWv36DCn6xqZ98qjHR0XFm9OoADGMIFCqsZ5u559x+XWprVNwY6EXj2lQ2KbppQostoPrRGbiMjU6biy/iFX0C7GRilL+4+QYKFEv+Kq0vmV2mvjeHHsqwo/RewgNYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733276630; c=relaxed/simple;
	bh=CKWsZb2yT8hh1m0dbBSisGGIc5ULADabbjpPZnjoPVc=;
	h=Date:Message-ID:In-Reply-To:References:Mime-Version:From:To:Cc:
	 Subject:Content-Type; b=bYFd7GEBFqIxhb9EgNwxAWVs0F2Y+lbYQT6mJ8IpXJaFGUnmuJbpbjzMICyAIbsSdxdVhLtkRqwUeG7Q/76Caa3yyuxGuROrKLIBT4UYuSRXVpXIgFAYRhJJFQvnUeXPIimcdbSNwiEAVXsI984+0tGhUtzoA+QSKiE+1nIkWPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=209.9.37.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mxhk.zte.com.cn (unknown [192.168.250.138])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mxde.zte.com.cn (FangMail) with ESMTPS id 4Y30fg5pgTzBRHKW;
	Wed,  4 Dec 2024 09:43:39 +0800 (CST)
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4Y30fW0MXQz5B1Kq;
	Wed,  4 Dec 2024 09:43:31 +0800 (CST)
Received: from szxlzmapp05.zte.com.cn ([10.5.230.85])
	by mse-fl1.zte.com.cn with SMTP id 4B41hJ29026879;
	Wed, 4 Dec 2024 09:43:19 +0800 (+08)
	(envelope-from yang.yang29@zte.com.cn)
Received: from mapi (szxlzmapp05[null])
	by mapi (Zmail) with MAPI id mid14;
	Wed, 4 Dec 2024 09:43:21 +0800 (CST)
Date: Wed, 4 Dec 2024 09:43:21 +0800 (CST)
X-Zmail-TransId: 2b07674fb3b9401-089f3
X-Mailer: Zmail v1.0
Message-ID: <20241204094321160yp9RJKElKXTlg-q1OzYU-@zte.com.cn>
In-Reply-To: <20241203170816.3fe81941fe1866ca1672eba8@linux-foundation.org>
References: 20241203164848805CS62CQPQWG9GLdQj2_BxS@zte.com.cn,20241203170816.3fe81941fe1866ca1672eba8@linux-foundation.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <yang.yang29@zte.com.cn>
To: <jiang.kun2@zte.com.cn>
Cc: <bsingharora@gmail.com>, <david@redhat.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-doc@vger.kernel.org>, <wang.yong12@zte.com.cn>,
        <wang.yaxin@zte.com.cn>, <fan.yu9@zte.com.cn>, <he.peilin@zte.com.cn>,
        <tu.qiang35@zte.com.cn>, <qiu.yutan@zte.com.cn>,
        <zhang.yunkai@zte.com.cn>, <ye.xingchen@zte.com.cn>,
        <xu.xin16@zte.com.cn>, <akpm@linux-foundation.org>,
        <Liu.Jianjun3@zte.com.cn>, <tan.hu@zte.com.cn>,
        <jiang.xuexin@zte.com.cn>
Subject: =?UTF-8?B?UmU6IFtQQVRDSCBsaW51eCBuZXh0XSBkZWxheWFjY3Q6IGFkZCBkZWxheSBtYXggdG8gcmVjb3JkIGRlbGF5IHBlYWs=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 4B41hJ29026879
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 674FB3CA.000/4Y30fg5pgTzBRHKW

On Tue, 3 Dec 2024 16:48:48 +0800 (CST) <jiang.kun2@zte.com.cn> wrote:

> From: Wang Yaxin <wang.yaxin@zte.com.cn>
> the 'delay max' can display delay peak since the system's startup

What about also add 'delay min' ? This could help us get to know how
large the difference is between min and max, provide clues for optimizing
potential. This is also some benchmark tools do, like stream which print:
precision of your system timer.
-------------------------------------------------------------
Function    Best Rate MB/s  Avg time     Min time     Max time
Copy:          234195.8     0.073357     0.073357     0.073357
Scale:         163856.6     0.104847     0.104847     0.104847
Add:           177791.5     0.144944     0.144944     0.144944

And please also update Documentation/accounting/delay-accounting.rst.
Other parts LGTM, thanks!

