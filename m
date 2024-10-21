Return-Path: <linux-kernel+bounces-375005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 861499A7311
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 21:14:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35E9E1F22469
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 19:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65AF01FC7F5;
	Mon, 21 Oct 2024 19:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IjSIeixh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4AFB2209B
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 19:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729538068; cv=none; b=O7q5UTbdX6Ttc6Be552sZQEg7W5YhiCd0EQhsXVYfQxZOznJoj/mxij4AqF0wruuB0bEsVu3uGrS80t2UBKs1vAEyRyJsuijtrGXjIg4B9QAzphbyOPZ+ph5mADkN89OqSKT92soEj2RwzpKt4EEuGyL9bs2MYt1FiLHyFs+Vzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729538068; c=relaxed/simple;
	bh=Vp3VyPCEZtRWwIx4AQb+2QWWum+1wrgS2sZgatBVYI4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=LAbfy/pqUrAmwvnZ+kPqeQAdH/yrmb9f83hTi4JZiQDeEQ/AsLZgoYSmSCoZKZLA9rtZAn76vST43+1bfBgBNc3FyObxHuhgTm6u4s3vOUjTCg7oDiYJkWS0WaRfdh5BVjPO0pqfYm/FZ/dXzo776IPQIqKnJngeB1OUAZ1pRmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IjSIeixh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F05B2C4CEC7;
	Mon, 21 Oct 2024 19:14:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729538068;
	bh=Vp3VyPCEZtRWwIx4AQb+2QWWum+1wrgS2sZgatBVYI4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=IjSIeixhoW7LrHHtj3D38jNNHgcGJonJznArxuKKaj0syGR2VTke4/VV9Ys+zP4jT
	 d/Laq/3YCgme1Px0rjjUxULUUfiPD0tmvOAq6zhTPs7CpZeZmIegQbCraFvtVMZTaq
	 ooOvisJl2bN78AdIWi61Fqxn38ESfAE9rBjWvMGbFN4WKbuFNMYXuWyV5Q1DZ4doQw
	 5NwTtzW8JvrJE3z+qmgSmH83VrKr4ARei8LXHUlmNG2NclQR0p02CANeD1Xu0UukFJ
	 hTb4Wzud7w1WBbcoA/7BlrF95TuSJZe7IcsuUCH1o5Iq3buVX0BOIIJyiu8SWybhOa
	 yqOJPEtWCi3ew==
Date: Mon, 21 Oct 2024 14:14:26 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Justin Piszcz <jpiszcz@lucidpixels.com>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-nvme@lists.infradead.org
Subject: Re: 6.1.0-17: nvme nvme0: controller is down; will reset:
 CSTS=0xffffffff, PCI_STATUS=0xffff
Message-ID: <20241021191426.GA842491@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAO9zADza=73GsuzAcuyH-YfhS34qjkDtuJjGBReVGpfE6KN_ow@mail.gmail.com>

On Fri, Jan 05, 2024 at 09:49:58AM -0500, Justin Piszcz wrote:
> Hello,
> 
> Distribution: Debian Stable x86-64
> Kernel: 6.1.0-17
> 
> Reporting this as requested from the kernel message, I have now
> appended the recommended kernel boot parameters
> nvme_core.default_ps_max_latency_us=0 pcie_aspm=off and will see if
> this recurs.

Hi Justin, did anything ever come of this report?  Is it reproducible?
Did it seem to be related to suspend/resume?

> Jan  5 06:18:52 atom kernel: [295306.524933] pcieport 0000:00:06.0:
> AER: Corrected error received: 0000:00:06.0
> Jan  5 06:18:52 atom kernel: [295306.524979] pcieport 0000:00:06.0:
> PCIe Bus Error: severity=Corrected, type=Physical Layer, (Receiver ID)
> Jan  5 06:18:52 atom kernel: [295306.525004] pcieport 0000:00:06.0:
> device [8086:a74d] error status/mask=00000001/00002000
> Jan  5 06:18:52 atom kernel: [295306.525027] pcieport 0000:00:06.0:
> [ 0] RxErr                  (First)
> Jan  5 06:19:22 atom kernel: [295336.554420] nvme nvme0: controller is
> down; will reset: CSTS=0xffffffff, PCI_STATUS=0xffff
> Jan  5 06:19:22 atom kernel: [295336.554469] nvme nvme0: Does your
> device have a faulty power saving mode enabled?
> Jan  5 06:19:22 atom kernel: [295336.554489] nvme nvme0: Try
> "nvme_core.default_ps_max_latency_us=0 pcie_aspm=off" and report a bug
> Jan  5 06:19:22 atom kernel: [295336.614521] nvme 0000:03:00.0: Unable
> to change power state from D3cold to D0, device inaccessible
> Jan  5 06:19:22 atom kernel: [295336.614898] nvme nvme0: Removing
> after probe failure status: -19
> Jan  5 06:19:22 atom kernel: [295336.630497] nvme0n1: detected
> capacity change from 7814037168 to 0
> Jan  5 06:19:22 atom kernel: [295336.630502] BTRFS error (device
> nvme0n1p2): bdev /dev/nvme0n1p2 errs: wr 1, rd 0, flush 0, corrupt 0,
> gen 0
> Jan  5 06:19:22 atom kernel: [295336.630513] BTRFS error (device
> nvme0n1p2): bdev /dev/nvme0n1p2 errs: wr 2, rd 0, flush 0, corrupt 0,
> gen 0
> Jan  5 06:19:22 atom kernel: [295336.630542] BTRFS error (device
> nvme0n1p2): bdev /dev/nvme0n1p2 errs: wr 3, rd 0, flush 0, corrupt 0,
> gen 0
> 
> Regards,
> Justin

