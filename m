Return-Path: <linux-kernel+bounces-330427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FF27979E77
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 11:28:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAB3A1F22455
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 09:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FEBF14A4F5;
	Mon, 16 Sep 2024 09:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RHTFTBB1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B34CD132122
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 09:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726478894; cv=none; b=CWG0TmT3oziLMn6O/e8HX5mSiheSKUxJAWMJKgMNM3wfrtnFCZhEIbTvoqKOmraEOOCtLO+Rqqv1rXjSUux2nZrwhSLfTFZXSPVtWQZBP5gy/EGHJQQtMJXHjzwHbbRMpfb0yE05Yp4q1R9merUTxtazQPP4xHEKwJpiGHME0Mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726478894; c=relaxed/simple;
	bh=cgZc/BgRQ3td5Yw9a3GeSiVF4W9kLwymE9bQrLcXTyE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dOpOuWP26TxY6o/cMVK9n1UGEU/3lysnogKvauCgKENSy61HkfsooUCzRXFQGj4tKZof5FiJ6kqykFkJut7EVvf9ltBh//1z5nx7F+GnSLKVxAih7bxrHVs4mCelYWHnz672d4pnhISK4x7oqkI1QeGnG5R872QcENpaWsFoDg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RHTFTBB1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 906D3C4CEC4;
	Mon, 16 Sep 2024 09:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726478894;
	bh=cgZc/BgRQ3td5Yw9a3GeSiVF4W9kLwymE9bQrLcXTyE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RHTFTBB1RHQJECTBzjgnzq2ap9XivxUqLWC4wACIymL4WcOZKTDaxHezZYV5RLOs+
	 DBNEfT5PLDn2XPt4fVogxMNjh39foO/BvZtKATlRkFzRPW3OVBe5atD9zI5ZtZGDHs
	 Vg/BWQRV3GdtzISpskZb6KEsU6KzLjZ9HpjqKt/rp4UcDftWcqxWGKpM9HqqmXzyl7
	 HIjusTfLhY2ifMvDwemxW18I1/5ONSS0yp5XVGlhdtV58Q6dj40VqA/f6OxPiKm+85
	 zNuSdA8VP+1KRwFts+nKlHnE2XtfeJHI9pcm82CkNoZP3kmL8HZbBg5ZFCcJVTIb3A
	 WoqlXYlvbX3Bw==
Date: Mon, 16 Sep 2024 11:28:07 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Shen Lichuan <shenlichuan@vivo.com>
Cc: zhenyuw@linux.intel.com, zhi.wang.linux@gmail.com, 
	jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com, 
	tursulin@ursulin.net, airlied@gmail.com, simona@ffwll.ch, 
	intel-gvt-dev@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, opensource.kernel@vivo.com
Subject: Re: [PATCH v1] drm/i915/gvt: Correct multiple typos in comments
Message-ID: <hph6vzdz54megzoqwiqnozddog5oqzwn5oz3j4hcrevjav5q3n@r4cz7eq3buic>
References: <20240913021612.41948-1-shenlichuan@vivo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240913021612.41948-1-shenlichuan@vivo.com>

Hi Shen,

On Fri, Sep 13, 2024 at 10:16:12AM GMT, Shen Lichuan wrote:
> Fixed some spelling errors, the details are as follows:
> 
> -in the code comments:
> 	addess->address
> 	trasitions->transitions
> 	furture->future
> 	unsubmited->unsubmitted
> 
> Signed-off-by: Shen Lichuan <shenlichuan@vivo.com>

reviewed and merged to drm-intel-next.

Thanks,
Andi

