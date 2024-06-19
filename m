Return-Path: <linux-kernel+bounces-221643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 06D1590F6A8
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 21:03:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B30A41F2329C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 19:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52D15158A3B;
	Wed, 19 Jun 2024 19:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PtczeJAO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D71E134A5;
	Wed, 19 Jun 2024 19:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718823787; cv=none; b=nFu+bzmoWrmTLMGOEnzTzIj+IBsyibGGpjGsM2D/TtMc53iH9pxK1i8vkeYEbCkcygKEK1z5pIS92kxqwQDdxUEAAirPR2MZWVViCfZYLZslUi2oif2xze+cy1AS/JyRWw2rRUFbLGWeuWfQNZIzDPbwPyFCVQX5GiHe9DCH7g4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718823787; c=relaxed/simple;
	bh=Xwy3V0Pxn3Jw+0RFKV2xnezuQyIaBE0HcoYs2THUpfU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tz+D1mBUIiLCOv8dLT6uroj4zlXM9Go2FfcbXBQ4NQCRoijMKouyi0B0ekuM3u8Q+Pd8k6pjctdfeC5tmhdDDQqzn58qkF6dRqMu/kkG0Oa+QH4vaaAD0lIJNnxi9SdWDLyTkJ7a+/Urf4LiJqk2K3zYpRGZs1Sx8KShbwNc2w8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PtczeJAO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 627B6C2BBFC;
	Wed, 19 Jun 2024 19:03:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718823787;
	bh=Xwy3V0Pxn3Jw+0RFKV2xnezuQyIaBE0HcoYs2THUpfU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PtczeJAOjC1h4Dqpq9Or1imxLRZQgxBep8CmQjwca3j3MCot/DRMHRzLOrSK8rEge
	 rknCDq2LzPJ4pluLUe1terBZcPhxh08VkU+E0ioI65w0TYSceEGYjyAy2QdFs645eM
	 IC5N40nozXVh5yAIAoxWYDVlcq9Yzj0g/jdAd9eVt1qDzkTjcynvTU+ptg+sfaV/OR
	 uNPdzWH6nxRMjS7jaaYyKOl2J9e9S8LN2GYNvei5vAvkZu6c6c0tiWNkQzI4rICqIQ
	 qJUqtyy+lyIwxeM9Iy2ckLD8dSzPEDZolqgdxiXYtnC5nrUIwTdvn/mC6BWU+wq7ym
	 DDnmHvGRJOO7Q==
Date: Wed, 19 Jun 2024 20:03:03 +0100
From: Simon Horman <horms@kernel.org>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH net-next] net: smc9194: add missing MODULE_DESCRIPTION()
 macro
Message-ID: <20240619190303.GU690967@kernel.org>
References: <20240618-md-m68k-drivers-net-ethernet-smsc-v1-1-ad3d7200421e@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240618-md-m68k-drivers-net-ethernet-smsc-v1-1-ad3d7200421e@quicinc.com>

On Tue, Jun 18, 2024 at 10:56:28AM -0700, Jeff Johnson wrote:
> With ARCH=m68k, make allmodconfig && make W=1 C=1 reports:
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/net/ethernet/smsc/smc9194.o
> 
> Add the missing invocation of the MODULE_DESCRIPTION() macro.
> 
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>

Reviewed-by: Simon Horman <horms@kernel.org>


