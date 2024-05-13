Return-Path: <linux-kernel+bounces-177943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CE478C4684
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 19:54:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03D5828217C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 17:54:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 177E428E34;
	Mon, 13 May 2024 17:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="lCePoxvP"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C338824B2A
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 17:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715622877; cv=none; b=AGCCcZiOsV24dMz4EtzwLhMejCOPm4qyms19SpLuEBdu6i2rmwegkr20DZP/Onum1bjw2cyIAhhJk7273vezhWKzqaK/E/SohCaxAtB/C8Uypyc1+ddzLH8sUMdvd5OOr4odwenANyUKBHB0z4lJJGB6JYUqQzrT8u3jOdMJb2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715622877; c=relaxed/simple;
	bh=a/lbExuQyrYuQJQSUEnp9PA7ZrF8EE72p4WqgRxVGaQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=izEeMjtha+Bhp8Nj6gN9vww6F1x3O3Ko8RfYbCdF24WPfK5jSz0qIHqLaZb18dbjemmh6QXjGHW4uIIcp9fHQnI6ivUBYgALm4Zq5+UE6TeQwXD+8vFfZmrJcni3gF9Tap5oQ9WYNaBSUVITfirBbbCYO2pkq7TRbW23xJ5U27I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=lCePoxvP; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=0tvSw3k87a575SAtJyC80sy4OD60RZdZ41G3YevCSck=; b=lC
	ePoxvPLqxi9vLMZINKCS1xfwtdIB6OpniirjTG6UGSO0DLS2tSRRXK7jskwZsKLrbdq+vWy5D9S6S
	g7IIRrhEOkHqd5ElaWHlNI2IvaVe2dDm30nF0A7ovl+hWag8xe5DKFOFUU/GWEvdTcrnxSNbLq9fE
	EAWJP2X6j9BJ9ZY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1s6Zsf-00FKL7-3o; Mon, 13 May 2024 19:54:33 +0200
Date: Mon, 13 May 2024 19:54:33 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Stephen Langstaff <stephenlangstaff1@gmail.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>, linux-kernel@vger.kernel.org,
	"OlteanV@gmail.com" <OlteanV@gmail.com>
Subject: Re: drivers/net/dsa/dsa_loop_bdinfo.c build problems
Message-ID: <e307a237-68e3-40c9-be31-4fe3d560ada2@lunn.ch>
References: <CAHx5RXBfazB62qpbGGK3_YjwCFbiJbEXrgo88V6qHFdTW1CdRQ@mail.gmail.com>
 <338daebd-b4af-4a0c-951a-ad7f86dc4646@gmail.com>
 <CAHx5RXAOKBGXRgC8pqEyY3MZGXxj0-vrwnqg_WZqKreYp18dAg@mail.gmail.com>
 <7efffaa0-6330-4b01-b3d2-63eb063cbbb0@gmail.com>
 <CAHx5RXD8qFmbEytrPcd40Pj0VRo7uOvZjucrMj6Xxqw73YyS1Q@mail.gmail.com>
 <212a9464-d52b-4730-95b9-5a0aebd38c91@gmail.com>
 <CAHx5RXCWW5M-eW5v65bAkQWZemsU2NTvDv3jA9_XKz=+YP56Qg@mail.gmail.com>
 <688e54ec-3b29-4e3b-a2c3-f2c83b9c97b7@lunn.ch>
 <CAHx5RXBFdzsgKXR94gdZd2b=uz8PJDg4OjLPJxKtsdhcjJq3Qw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHx5RXBFdzsgKXR94gdZd2b=uz8PJDg4OjLPJxKtsdhcjJq3Qw@mail.gmail.com>

On Mon, May 13, 2024 at 06:40:19PM +0100, Stephen Langstaff wrote:
> On Mon, May 13, 2024 at 5:54 PM Andrew Lunn <andrew@lunn.ch> wrote:
> > As Florian pointed out, dsa_loop_bdinfo.o should be built into your
> > kernel. When you insmod dsa_loop.ko, it should match the data in
> > dsa_loop_bdinfo to the dsa_loop driver an instantiate an instance of
> > it. Do you see that happening?
> 
> Well, if I fiddle with the Makefiles to get dsa_loop_bdinfo built as a
> module (as opposed to not building at all) then I see the following
> behaviour:
> 
> root@machine:~/dsa_test# ls
> dsa_loop.ko  dsa_loop_bdinfo.ko
> root@machine:~/dsa_test# modprobe dsa_core
> root@machine:~/dsa_test# insmod dsa_loop_bdinfo.ko
> root@machine:~/dsa_test# insmod dsa_loop.ko
> root@machine:~/dsa_test# lsmod
> Module                  Size  Used by
> dsa_loop               16384  0
> dsa_loop_bdinfo        16384  0
> dsa_core              118784  1 dsa_loop
> ...
> 
> ...and I see no new interfaces reported by ifconfig -a
> [just the existing eth0, eth1 and lo0 interfaces]
> 
> I will revert my changes to the Makefiles and confirm that
> dsa_loop_bdinfo.o does not get built into the kernel - that's an
> overnight build for me so bye for now!

I think most developer cross compile the kernel on a big machine. I
also tend to build in everything i need, so its all in one file, which
i get uboot to tftpboot. It makes the whole build/boot/crash cycle
much master.

     Andrew

