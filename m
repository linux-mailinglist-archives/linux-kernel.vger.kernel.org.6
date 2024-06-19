Return-Path: <linux-kernel+bounces-221644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0747190F6AE
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 21:06:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 970B8B24DDD
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 19:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB175158D62;
	Wed, 19 Jun 2024 19:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hFrd2/LR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 301CB1E4B0;
	Wed, 19 Jun 2024 19:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718823977; cv=none; b=ToCaklXJcbwrhPC6cX0Z1dWMkZXOtM6q7gi66vEaCjpKBHXhu29BjRNvVYP/ltl9KQvZ/ycoYAok3Ma8i1lwZzrMuWK6Xd3xlXfFSqv7tttXbCxx2mxVLF4U24bZFnyQwMPzXDyxJ7laARxezj6v1EjOuNb72FMZ43EeXx8e7i8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718823977; c=relaxed/simple;
	bh=TpQtGaDPUsBPl4Brv7an9yTmrPCxfE/HO8pnv+yxffw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VmnxuzGHXqw6PIhIgDBPXivTUcEX0uz59hmtVetpfbh31lDK/mdGXwxh59AWu0o36Yczc6QwJ0uR1yoFs9RQ5Vkn0jkgjGkDvBDVuiWzzbHAzHuxM8ti4TAyKctDoatTFOdOs8glcOgrUj6pjiJ8DLReIHtm9Xu6jzx421cgf7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hFrd2/LR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D383C2BBFC;
	Wed, 19 Jun 2024 19:06:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718823976;
	bh=TpQtGaDPUsBPl4Brv7an9yTmrPCxfE/HO8pnv+yxffw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hFrd2/LRP+AD0JzFRLE1FLvBWIoOmjCadoi/A0XHlu0rPire5VnC9xC+jREX480Vk
	 Td44tsdmwX10KS6hFE6//DbP709JmaiOhv8wDYQqj0Vq9ckxxpDCi91EHsrCZD1rFh
	 zu/r4mVPcmvI8SdBIkTcSiqoko4ZXhykvneZnQWeyQ/+HTVMcI2qXv/jRlUKlJ7cyG
	 Hd3d4sjZaCaAUMYuTgn5Mc3WiL8l1puBoEd9kbYpKwrEQIJuqeufPFCA4NcrmxHhmP
	 BiZX15PWq6/s4kVc/4vlyQ15n+Hqd4WyDkpqzPhAJ63Xo2B/1YrnUpkYEc2Wac4i7T
	 0HMBPQ0qVzr/A==
Date: Wed, 19 Jun 2024 20:06:12 +0100
From: Simon Horman <horms@kernel.org>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH net-next] net: amd: add missing MODULE_DESCRIPTION()
 macros
Message-ID: <20240619190612.GV690967@kernel.org>
References: <20240618-md-m68k-drivers-net-ethernet-amd-v1-1-50ee7a9ad50e@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240618-md-m68k-drivers-net-ethernet-amd-v1-1-50ee7a9ad50e@quicinc.com>

On Tue, Jun 18, 2024 at 10:26:20AM -0700, Jeff Johnson wrote:
> With ARCH=m68k, make allmodconfig && make W=1 C=1 reports:
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/net/ethernet/amd/a2065.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/net/ethernet/amd/ariadne.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/net/ethernet/amd/atarilance.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/net/ethernet/amd/hplance.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/net/ethernet/amd/7990.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/net/ethernet/amd/mvme147.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/net/ethernet/amd/sun3lance.o
> 
> Add the missing invocation of the MODULE_DESCRIPTION() macro to all
> files which have a MODULE_LICENSE().
> 
> This includes drivers/net/ethernet/amd/lance.c which, although it did
> not produce a warning with the m68k allmodconfig configuration, may
> cause this warning with other configurations.
> 
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>

Reviewed-by: Simon Horman <horms@kernel.org>


