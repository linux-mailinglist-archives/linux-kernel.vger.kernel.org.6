Return-Path: <linux-kernel+bounces-306581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DC6C9640C7
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 12:00:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E86211F22CEB
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 10:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AF0118D62F;
	Thu, 29 Aug 2024 10:00:30 +0000 (UTC)
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D7F318C90F
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 10:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.16.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724925629; cv=none; b=LNQAWh29sLJQGu+gItzKaGX0Jz2heSgzEJ5OjB/A1oO4+PbUpa8l6Lil/WLgKMRUmSP6MMM7ieqQ5LmGVvvI08FzyCjWXHI8XHdg5Q2JGYa0v2fom9kn9nYFOsXAzmohZKlt78L2PcfyI4yvgsuYuOHZYLZjSWiq370WzxkAUEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724925629; c=relaxed/simple;
	bh=rXqBPWjabl2AhYMj8Mw3GVIkTaIxCc1p93GMRYckx+I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MAcoMrwnWI1vA8O26F6caAO/YpzoKlre7zmHTrbslGyg+2wdcrcR63OLOk98gMEiFrFpSANp9TIuAnCppkrlCd1kGgjEKiz4YH9Xr9SsZ4FLFBWIFSxt0rWV/EAs80fDH1YUqzI0gKDDQdzcaMRPy9/qfBGcP0RkrUneqA0edVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn; spf=pass smtp.mailfrom=shingroup.cn; arc=none smtp.client-ip=54.206.16.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shingroup.cn
X-QQ-mid: bizesmtpsz6t1724925540tsf67u3
X-QQ-Originating-IP: 82g7hF6P3776kDZusegigq9HOwuoLVAfdSLLth4y1SI=
Received: from HX09040029.powercore.com.cn ( [58.34.117.194])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 29 Aug 2024 17:58:50 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 17198672222810151537
Date: Thu, 29 Aug 2024 17:58:35 +0800
From: Luming Yu <luming.yu@shingroup.cn>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: "shenghui.qu@shingroup.cn" <shenghui.qu@shingroup.cn>,
	npiggin <npiggin@gmail.com>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	mpe <mpe@ellerman.id.au>, "luming.yu" <luming.yu@gmail.com>,
	=?utf-8?B?5p2o5L2z6b6Z?= <jialong.yang@shingroup.cn>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 2/2] powerpc/debug: hook to user return notifier
 infrastructure
Message-ID: <7435A42D8345CED1+ZtBGS_CW6uZL0YbM@HX09040029.powercore.com.cn>
References: <B375A36C9C4D73FF+20231218031338.2084-1-luming.yu@shingroup.cn>
 <8734vzsw0q.fsf@kernel.org>
 <8734vyn1ky.fsf@mail.lhotse>
 <2acd6623-952b-4659-bc26-c632e94560a8@csgroup.eu>
 <0638f0a2-782b-411f-9937-c62d99e9562b@csgroup.eu>
 <tencent_4F2B3C0025D5A1722470D582@qq.com>
 <bd4908d2-cea9-406b-902f-618626e74c88@csgroup.eu>
 <B6A4506E3DD1F93F+Zs7Iq_EF799NyWHK@HX09040029.powercore.com.cn>
 <3fbdc957-2db4-4148-b325-263384f9a196@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3fbdc957-2db4-4148-b325-263384f9a196@csgroup.eu>
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:shingroup.cn:qybglogicsvrgz:qybglogicsvrgz8a-1

On Wed, Aug 28, 2024 at 09:27:23AM +0200, Christophe Leroy wrote:
> 
> 
> Le 28/08/2024 à 08:50, Luming Yu a écrit :
> > On Wed, Aug 28, 2024 at 07:46:52AM +0200, Christophe Leroy wrote:
> > > Hi,
> > > 
> > > Le 28/08/2024 à 05:17, 虞陆铭 a écrit :
> > > > Hi,
> > > > 
> > > > it appears the little feature might require a little bit more work to find its value of the patch.
> > > > 
> > > > Using the following debug module ,  some debugging shows the TIF_USER_RETURN_NOTIFY
> > > > bit is propagated in __switch_to among tasks , but USER_RETURN_NOTIFY call back seems to
> > > > be dropped somewhere on somone who carries the bit return to user space.
> > > > side notes:
> > > > there is an issue that the module symbols is not appended to /sys/kernel/debug/tracing/available_filter_functions
> > > > which should be sovled first to make it easier for further debuggig.
> > > 
> > > As far as I can see, user return notifier infrastructure was implemented in
> > > 2009 for KVM on x86, see
> > > https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Fall%2F1253105134-8862-1-git-send-email-avi%40redhat.com%2F&data=05%7C02%7Cchristophe.leroy%40csgroup.eu%7C260e5ecf10764312459c08dcc72dc2f5%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C638604246584044745%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7C%7C%7C&sdata=3hjAzcVu3xOq0QNK5WINQ8trLd9Xp7XCiQjw2htabpQ%3D&reserved=0
> > > 
> > > Can you explain what is your usage of that infrastructure with your patch ?
> > > You are talking about debug, what's the added value, what is it used for ?
> > one example: I was thinking to live patch kernel at the moment that all cpus are
> > either returning to user space or going into idle. But I'm not sure if it is truly
> > valuable. secondly, it can help us get more accurate user/system time
> > accounting via tracing rather than through sampling technique.
> > The third: it could have similar usages in kvm for ppc as x86 for tsc_aux.
> > etc :-)
> 
> Thanks.
> 
> Don't we already have a very accurate user/system time accounting with
> CONFIG_VIRT_CPU_ACCOUNTING_NATIVE ?
Yes, there are many such instrumented code on various entry/exit code paths 
that could be removed in future, if we could find that the common call back 
mechanism like user notifier could be more clear and better implementation 
for such needs. :-)
> 
> Christophe
> 
> 


