Return-Path: <linux-kernel+bounces-330475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 14DD3979F04
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 12:13:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2F41284BD8
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 10:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 270DE14C5BF;
	Mon, 16 Sep 2024 10:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EjjIR17/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8980F149C4D
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 10:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726481613; cv=none; b=dSVCqEtFEpS2zTgLPV0uGwxSV2KYdyScojyy4h3Qbcz0hEd9oSnx3Cu7pngMByQgU/q8n2Rbe6dFmojbDJv1FDZAnlCjO/lwacH9zxCPpH1dtxJI+EBRfAYkk9FjxZeEnT5UOkF7CfD8lU6c2dmWCsR40cRG0r95FPjhpzugz08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726481613; c=relaxed/simple;
	bh=xxi8czYF+zpfW+NyqGizSO/JM3i+2CVO1xmYS5v4kys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g3C9yecx8NpxnIQ3V1+x+r9uvAAmBIB3MalbmC1WZcZSoIiuomftgijO7Y8lEksbMgTaYy/3SS7owoDANzX3tR4K+A641rmr3xmvjIYPdgaXf2Oi3aPrDk79Qy5T87RscjHdKYdQQkTsgZ1bnghv90EW0Lm+5w+EjArTrCRT/84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EjjIR17/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73093C4CEC4;
	Mon, 16 Sep 2024 10:13:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726481613;
	bh=xxi8czYF+zpfW+NyqGizSO/JM3i+2CVO1xmYS5v4kys=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EjjIR17/sYDnmA4FJ+9blNvJv3jaQ4FBIlfdqRE/E+CJaBWknTTOoLKKoRiUbc2A5
	 VvOXmDeoBCXy/lugVULyXiuBvJ/IsKlnQS/6anynPzHO60jKP6SHtsGW4SXAoVL5na
	 O+0vVWjnwarW9whmiB1/LQP0B9fu2OCtjgTWR/ApTj4PYOVMueD5fb7shSMBL0Chk9
	 uVHo8DCz9qYKdfyQieC+7+d+/FT3lYRXJBLQ8xVze27sLpLIlKVzDZF99KDQK1iWqw
	 Lpo2E++c945g9lJDVfRSVh2co9Bei6Uyh8GvwOtU8OlvM82+5Ti7lWg1Xt7S0od3EZ
	 3eofwqyAgDCcw==
Date: Mon, 16 Sep 2024 12:13:27 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Yan Zhen <yanzhen@vivo.com>
Cc: jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com, 
	rodrigo.vivi@intel.com, tursulin@ursulin.net, airlied@gmail.com, simona@ffwll.ch, 
	intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	opensource.kernel@vivo.com
Subject: Re: [PATCH v1] drm/i915: Fix typo in the comment
Message-ID: <pb2orbzsopaoxojtx6gdgr23idqdpuleo2gclwuhytu5ntblsq@643rpnj4mpph>
References: <20240914064141.295712-1-yanzhen@vivo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240914064141.295712-1-yanzhen@vivo.com>

Hi Yan,

On Sat, Sep 14, 2024 at 02:41:41PM GMT, Yan Zhen wrote:
> Correctly spelled comments make it easier for the reader to understand
> the code.
> 
> Replace 'ojects' with 'objects' in the comment &
> replace 'resonable' with 'reasonable' in the comment &
> replace 'droping' with 'dropping' in the comment &
> replace 'sacrifical' with 'sacrificial' in the comment.
> 
> Signed-off-by: Yan Zhen <yanzhen@vivo.com>

Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com>

Thanks,
Andi

