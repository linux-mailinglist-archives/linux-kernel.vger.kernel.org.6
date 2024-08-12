Return-Path: <linux-kernel+bounces-283041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DBE9594EC3C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 14:01:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 971202823B7
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 12:01:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45AB217A588;
	Mon, 12 Aug 2024 12:00:38 +0000 (UTC)
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD2E41537DD
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 12:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723464037; cv=none; b=Vl1S9GO9LQ9Adr6OeCriOZ6UWgb86BoIMEsRFd2qtMzc2wak7khVQ4c0evDMEMwhkEZIvrzvd+7631M0Uac0/SSMvBIy4fUi5HCWDAbVLFs9IaQr+fRaMlKVMg+TZKKJX1tXeyhqJDnhf/EYnx3We98/beOJAYNU8UD+hhmYKeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723464037; c=relaxed/simple;
	bh=Sw6nOtsjUawzWckAsMCiWjTCUK3fPF1rxbh/ZK8ufXg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=nzPOBDyPHZ2RjfqEMiPEYP20lrKREsFOGylep2yddqesDvxz7e/zYwwW0bvKPXoHV5287eBaTz8NtdDyrFxQJaDfiofqoxuuQPKihKO285+sOSdSdSmQOQ25I1Hy2lVMYChCsfONW/m+FLtgO6ugcmxpTrmqrp9rfV4+yYnVIMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4WjCl42fKCz4x9G;
	Mon, 12 Aug 2024 22:00:32 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: sean.anderson@linux.dev, camelia.groza@nxp.com, linux@treblig.org
Cc: linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240528231123.136664-1-linux@treblig.org>
References: <20240528231123.136664-1-linux@treblig.org>
Subject: Re: [PATCH] soc/fsl/qbman: remove unused struct 'cgr_comp'
Message-Id: <172346398138.772106.1480775033029305821.b4-ty@ellerman.id.au>
Date: Mon, 12 Aug 2024 21:59:41 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Wed, 29 May 2024 00:11:23 +0100, linux@treblig.org wrote:
> 'cgr_comp' has been unused since
> commit 96f413f47677 ("soc/fsl/qbman: fix issue in
> qman_delete_cgr_safe()").
> 
> Remove it.
> 
> 
> [...]

Applied to powerpc/fixes.

[1/1] soc/fsl/qbman: remove unused struct 'cgr_comp'
      https://git.kernel.org/powerpc/c/06ce0af34177a110d6a5cf71f924965b9b230691

cheers

