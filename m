Return-Path: <linux-kernel+bounces-221642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB66A90F6A0
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 21:02:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 813B5281382
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 19:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D8E9158A33;
	Wed, 19 Jun 2024 19:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pzxiIS7K"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9756950275;
	Wed, 19 Jun 2024 19:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718823714; cv=none; b=BdK7PEMW72A64cIwIJxit035DCoSNihl2h4L/1uQ5Iu2c6up3xvwmy/9ikZz0956fppk0Aq9ngnVTps5fZeIuQ516HXYcMsLpsG97QZuaWSnFm00+6oAgKJaITfwV4IG6S/XU8r2252y+8hWGPXS5SdCnmAJ9FuemGr24pP99pY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718823714; c=relaxed/simple;
	bh=ZyktHRdkQ9aLjIQfaL9COXNHaw2WpPDHeYSo8xRP18Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HiYiGTmOho3tFTZlzMGGe58x6bvbQWJff2KytghwtkMACY0OmRNnvuxknA5RSmd15P7YtXjkokm7UQvzUYOFAaEfa0VsSP0iBGyAcDf8Nb3qRAVkj5VicTgynMWLkTIYIfoPj4htsmDoBPxRB5cNRDhYUARDZkY2UOVdqJ3iEWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pzxiIS7K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5477CC2BBFC;
	Wed, 19 Jun 2024 19:01:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718823714;
	bh=ZyktHRdkQ9aLjIQfaL9COXNHaw2WpPDHeYSo8xRP18Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pzxiIS7K5qV5AtDeESsZesZtoQKbYT8PLXWrJ961CBeNFcf85FBx0/4AAUqIKrvm6
	 epHXBj2Ltmxuk4t1m51UHFBobo7A6Jac+mRHDRuqXm1Ho7Fhd3wscgZUCcJHtFmwJQ
	 5ojZPQRbG3eSlX3hNe5t6gfF76LZXyK+NniRcSaCIJX1YOECry6NjKCskyMCByrAMi
	 gv54LMZEFbjcVrTXKPDSyknIiGkz7FZVnQ8OddtgUmmXMMWATdhSeLhpPx8BZmIu9L
	 VHC1tdliWM4S8sOm9gFYUCypxlqRSgpRQSl9zMhfvXV6sTGJzozAFZJd6cehMZpxX0
	 b5xnyoi04O0zA==
Date: Wed, 19 Jun 2024 20:01:50 +0100
From: Simon Horman <horms@kernel.org>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH net-next] net: ethernet: mac89x0: add missing
 MODULE_DESCRIPTION() macro
Message-ID: <20240619190150.GT690967@kernel.org>
References: <20240618-md-m68k-drivers-net-ethernet-cirrus-v1-1-07f5bd0b64cb@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240618-md-m68k-drivers-net-ethernet-cirrus-v1-1-07f5bd0b64cb@quicinc.com>

On Tue, Jun 18, 2024 at 10:41:54AM -0700, Jeff Johnson wrote:
> With ARCH=m68k, make allmodconfig && make W=1 C=1 reports:
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/net/ethernet/cirrus/mac89x0.o
> 
> Add the missing invocation of the MODULE_DESCRIPTION() macro.
> 
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>

Reviewed-by: Simon Horman <horms@kernel.org>


