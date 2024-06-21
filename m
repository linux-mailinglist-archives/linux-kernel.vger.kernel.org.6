Return-Path: <linux-kernel+bounces-225194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 34937912D69
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 20:46:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D765B1F25AF4
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 18:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAB2D17B43C;
	Fri, 21 Jun 2024 18:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RyDOWkzQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1380B5BAF0;
	Fri, 21 Jun 2024 18:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718995593; cv=none; b=rTNcYmtUCJg6YLe/EufT2uxq6DobICd4MD3UxMZCJqYYUAzipRUlbpkV4zebM5Ie4vlXdFSFMmwC+8kObtQYQLsGgGuGZnp3vfsz0HFCpC1+ntodECgWM9UmXtuAP05m0F2hqnt+lNLJuhgyUVvFswnok5F0+5uon0FR2kfVMLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718995593; c=relaxed/simple;
	bh=hGWFaeKo6xY0d8c6EUHTKFxGmvR2STDskrDV3QJjCJ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GwhH22s/SFfVxNtwyxueOt5h7rD9MB6d0521rC3YNjAOqV1GDmmGx3OOXa29/1mve8iN1MbwrLnqzhWqcZu3QQu0RemwHJFBJHAtLULyp/Kbnok0c0AUh+7pVdNbqwMGEfAgiIXQSV131CH9wqrap5+EufAYkQ43PldT66aOiSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RyDOWkzQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE150C2BBFC;
	Fri, 21 Jun 2024 18:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718995592;
	bh=hGWFaeKo6xY0d8c6EUHTKFxGmvR2STDskrDV3QJjCJ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RyDOWkzQNhc4cnXSG2+ek5wjUB23AHoh1Ua8eWl/X4+KBDAwZniV3sgHnVFk3ra/h
	 3D+40sNMNRBX7a1L5S+ybM8/mqf+EQl0FhDyXIj9SNtt5Bwv9VRoudFOQyH2DFyanv
	 vRMtNF6QO3NZXIQwx930cKGMkM9hi/zk4l747fxdgIOSBx04HBxK/B8Y68yasRvQ/t
	 hDNPUVKVMpRDXB03G6mo03W6Dc/yBydkk40hHLp9FmEeM2dFzloahpIXpv99c4/OnR
	 UzvxKIl0Mrk+Ma1OV9ahWztP04cuOphcoNqbwDlhMZljBE62Qo+/kpka3ubzqMGZOz
	 YfUxWJlVcC15g==
Date: Fri, 21 Jun 2024 12:46:29 -0600
From: Keith Busch <kbusch@kernel.org>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org, Eric Curtin <ecurtin@redhat.com>
Subject: Re: [PATCH v2] nvme-apple: add missing MODULE_DESCRIPTION()
Message-ID: <ZnXKhUMDenD4tnrn@kbusch-mbp>
References: <20240620-md-nvme-apple-v2-1-72e9d7151a1f@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240620-md-nvme-apple-v2-1-72e9d7151a1f@quicinc.com>

On Thu, Jun 20, 2024 at 09:42:18AM -0700, Jeff Johnson wrote:
> make allmodconfig && make W=1 C=1 reports:
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/nvme/host/nvme-apple.o
> 
> Add the missing invocation of the MODULE_DESCRIPTION() macro.

Applied to nvme-6.10.

