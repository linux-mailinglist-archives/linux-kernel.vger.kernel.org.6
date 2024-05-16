Return-Path: <linux-kernel+bounces-181184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0DB68C789D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 16:48:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4E1DB2229C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 14:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 288DA14D2AE;
	Thu, 16 May 2024 14:48:30 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB89214B973
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 14:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715870909; cv=none; b=IwdHQxEULl4GTatuNl/AWvm5TXWH8/Gm2aVwF4SuEcSZv04Qrzu0FnPQNYiI5mZ6wjsZrn+9bP1IXpChda0cP/geEX5nJVPv+LLxnd9qamsweOuo3Q2kzSh9YzfTj0+pjV4alyxtRnk+kiwaqSbRVY2znAC36hF7gW0+9NxYF0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715870909; c=relaxed/simple;
	bh=eGibcuJLfqXum3ESdm+NGKonua1wTXgzFMQgE8FqEsY=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FBy5urwP3wuF+hdmtczdPqO/Gw8tWexolOIRki3yVCHlS1FMIPkK9Gn0pAJrHL5QukQqv5s8fK2Bs7AuUYnkF0iek++ThDVh2Eu6c/q3yXfwbbkjSd3jcz3joSU1H4CtpeLgpYUJzKjQzq0IroMUHcr+bA2ra7542CyWEQuMhZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VgCYK2wGZz6J6mh;
	Thu, 16 May 2024 22:44:53 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id D29B4140A36;
	Thu, 16 May 2024 22:48:25 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 16 May
 2024 15:48:25 +0100
Date: Thu, 16 May 2024 15:48:23 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Kousik Sanagavarapu <five231003@gmail.com>
CC: Nathan Chancellor <nathan@kernel.org>, kernel test robot <lkp@intel.com>,
	Nishanth Menon <nm@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>, Julia
 Lawall <julia.lawall@inria.fr>, <llvm@lists.linux.dev>,
	<oe-kbuild-all@lists.linux.dev>, Shuah Khan <skhan@linuxfoundation.org>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 2/3] soc: ti: knav_qmss_queue: do device_node auto
 cleanup
Message-ID: <20240516154823.00000974@Huawei.com>
In-Reply-To: <ZkG_7wJvIjZ4ZlcV@five231003>
References: <20240510071432.62913-3-five231003@gmail.com>
	<202405111846.3m9z398l-lkp@intel.com>
	<ZkCZTv0Gci3xxKtw@five231003>
	<20240513064451.GB652533@thelio-3990X>
	<ZkG_7wJvIjZ4ZlcV@five231003>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Mon, 13 May 2024 12:53:27 +0530
Kousik Sanagavarapu <five231003@gmail.com> wrote:

> On Sun, May 12, 2024 at 11:44:51PM -0700, Nathan Chancellor wrote:
> > On Sun, May 12, 2024 at 03:56:22PM +0530, Kousik Sanagavarapu wrote:  
> > > On Sat, May 11, 2024 at 06:12:39PM +0800, kernel test robot wrote:  
> > > > Hi Kousik,
> > > > 
> > > > kernel test robot noticed the following build errors:
> > > >   
> > > 
> > > [...]
> > >   
> > > > All errors (new ones prefixed by >>):
> > > >   
> > > > >> drivers/soc/ti/knav_qmss_queue.c:1853:3: error: cannot jump from this goto statement to its label  
> > > >                    goto err;
> > > >                    ^
> > > >    drivers/soc/ti/knav_qmss_queue.c:1855:22: note: jump bypasses initialization of variable with __attribute__((cleanup))
> > > >            struct device_node *regions __free(device_node) =
> > > >                                ^  
> 
> [...]
> 
> > > Seems like gcc didn't catch this when I compiled locally.  
> > 
> > FWIW, you may notice this as you do more conversions. The fact that GCC
> > does not warn at all is a GCC bug as far as I am aware (i.e., clang's
> > error is correct):
> > 
> > https://gcc.gnu.org/bugzilla/show_bug.cgi?id=91951
> > 
> > which has come up in other places:
> > 
> > https://lore.kernel.org/20240425174732.GA270911@dev-arch.thelio-3990X/  
> 
> Thank you so much for these links :)
> 
> All my internet searches ended up at stackoverflow posts which didn't
> even describe the problem correctly, which also lead me to write an
> email explaining a partly erroneous solution, which is sitting in my
> mailbox ;)
> 
> Thanks again, these will help a lot.

Independent of all this, it's not a good idea form a readability point
of view to mix automated and manual cleanup.  So in cases like this
where you want to do scope based cleanup, use separate functions
that have appropriately defined scope (or brackets for the really minor
cases).

Here, you may just be able to push the device_node get into
knav_queue_setup_regions() for example.

Jonathan

> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel


