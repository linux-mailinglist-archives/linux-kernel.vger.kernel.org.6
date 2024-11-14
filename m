Return-Path: <linux-kernel+bounces-409788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 059209C91AB
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 19:31:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C56A9B2A9A1
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 18:23:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4CD11991A9;
	Thu, 14 Nov 2024 18:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c3ZbSyqH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E08381C4;
	Thu, 14 Nov 2024 18:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731608577; cv=none; b=Yp0gC20ZNhQYdCzBxaWDsDv0J05QwMAbvkxdc95YR65Q36KG8QaLheHvSBJIcA09nhhMCfc5KlHSn1uFJd/eoxGEUzMnVmX0DrveSmsHOa5C9OCC15lWvuNNihd8ASUNvPKk/ft31Llraz7H3APYAwCwoghrSBTRZLYHs/9IG9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731608577; c=relaxed/simple;
	bh=uxKa3UbqbThBSQ/sXmpGGOfKjgPA/WHWjeMCscBLznw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wav1kmLBVPnV1K3ak77FmTigd1/5Bx+GE9icOQXpyF2J+GZFZak5tCg2xj35eYRzomox4E8Yr86UzNdiAa2hBSNUOmsAlNClLmqnhijGQVqeo7tmX1YCqulSNA40OE5Pnu1jkcd8eALCOKK2svw8FGN6gwzsMAY0bQ/+CaaKyxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c3ZbSyqH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68C48C4CECD;
	Thu, 14 Nov 2024 18:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731608576;
	bh=uxKa3UbqbThBSQ/sXmpGGOfKjgPA/WHWjeMCscBLznw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c3ZbSyqH+16FNO8/2uiTss5VdTLttsEMwFrp9U3d4mN19rN5iIMFhb7fEHxsjVeJt
	 wV2ATyCE8q+1eTduVgwtQ7lNuOwGlS57YCZl/uXYKplejVC1zBwzo6/8Ukks9NtRBH
	 0Tqw0vLZozDBM9cKv3XmgY2voRBOpUIxInYv23rOTKTb2euUFnJQfcGRooKddno1qO
	 /u0EosdlfUdYZXIy2ogWKBYO5DF2jdJEVP8VT/IieEPChmCmFUEOwASD5YNFh13ne1
	 eIxrBS/Izui4GZEbWSdfRNy7+3+bjUzO3vkgtRKoUjfTts5we010XY2YUbdrOFCOfi
	 nqejl2VJh2u0A==
Date: Thu, 14 Nov 2024 18:22:52 +0000
From: Simon Horman <horms@kernel.org>
To: jiang.kun2@zte.com.cn
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, corbet@lwn.net, jmaloy@redhat.com,
	lucien.xin@gmail.com, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	tu.qiang35@zte.com.cn, xu.xin16@zte.com.cn
Subject: Re: [PATCH linux-next] Documentation: ticp: fix formatting issue in
 tipc.rst
Message-ID: <20241114182252.GE1062410@kernel.org>
References: <20241114200611368_vpMExu265JwdZuArEo_D@zte.com.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241114200611368_vpMExu265JwdZuArEo_D@zte.com.cn>

On Thu, Nov 14, 2024 at 08:06:11PM +0800, jiang.kun2@zte.com.cn wrote:
> From: tuqiang <tu.qiang35@zte.com.cn>
> 
> The hyphen is removed to have the same style as the others.
> 
> Fixes: 09ef17863f37 ("Documentation: add more details in tipc.rst")
> Signed-off-by: tuqiang <tu.qiang35@zte.com.cn>
> Signed-off-by: Jiang Kun <jiang.kun2@zte.com.cn>

Reviewed-by: Simon Horman <horms@kernel.org>


