Return-Path: <linux-kernel+bounces-330430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7F6E979E7D
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 11:28:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6453928320C
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 09:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82AAB14BFA2;
	Mon, 16 Sep 2024 09:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o2V+2BTJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC9014B962
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 09:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726478924; cv=none; b=f+xthZiIDTmhayrOZU8Jv9WzXaYM+cbrjhzE7gFuYuoBTTUI4IqRbE9iM3ZgtMsP3bZqOgC0Kwnct+9LG4B3pnppkTA4x2Fi6BCVuWHAOjAzjGJK0GVLcE6UGuzuQGiJlfsO2aKMf+p3bfMDst9R4Uql2B3knTGxmdaU0hOGAaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726478924; c=relaxed/simple;
	bh=HHUgW1boYFxsRq7ez/mJftbzVuWDocQVG+uAfB4jUpg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QmbRxqT5PCQz+SAzLrAJVYY24fobUwyw5Bb0cKqdw7ylKS2leTwcufHBxWeYqDrOCayhS2HFTgYe2ZdA+SXd+eolUjBx3QCzLobgvYyx9lfciqJIrOwbhqho9H1+/vImf5lTsFFT/g8YjsWQWd6NvKZYA0agxHdpFCs8Q3bKNEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o2V+2BTJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79E4BC4CECD;
	Mon, 16 Sep 2024 09:28:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726478924;
	bh=HHUgW1boYFxsRq7ez/mJftbzVuWDocQVG+uAfB4jUpg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=o2V+2BTJYV3NhsJTPZR0edYF0TIE5JqINAzERFaJWLuAbj1GVVCzzHgW7e21Bs9MS
	 MW50QT88ifdVFoDKkDgEH9ksLco0WTiM4uXWVwcvwjQlFRf4vVfeni/ijF2pPjjo0B
	 H6Rtu4Ew0GRAGsYxfjfKkhg5IcNXOb0t4GXDKXiUMt6ABfQNHtdo9tSIZso3qNt9dn
	 zPsFgF5uqq9JeCnvPlDjCBHuurszTYKSljTOwWbeEjpse9OsONC+gigw+HlPqElOB4
	 1nLnTj912VaGn0jHMUqvY3NyuBL+iF4W9LAWvOU4RdwnUsCW8Cl8I+87Nl+tlr7UOQ
	 mus1sRdlVEwww==
Date: Mon, 16 Sep 2024 11:28:38 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Yan Zhen <yanzhen@vivo.com>
Cc: jani.nikula@linux.intel.com, rodrigo.vivi@intel.com, 
	joonas.lahtinen@linux.intel.com, tursulin@ursulin.net, airlied@gmail.com, simona@ffwll.ch, 
	intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	opensource.kernel@vivo.com, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v1] drm/i915/display: fix typo in the comment
Message-ID: <hl7izclcyvkwi3z42iud3fv6aolzrmvilcd6gt4f2uyf7cefdz@2wswztqazz3g>
References: <20240913061727.170198-1-yanzhen@vivo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240913061727.170198-1-yanzhen@vivo.com>

Hi Yan,

On Fri, Sep 13, 2024 at 02:17:27PM GMT, Yan Zhen wrote:
> Correctly spelled comments make it easier for the reader to understand
> the code.
> 
> Replace 'platformas' with 'platforms' in the comment &
> replace 'prefere' with 'prefer' in the comment &
> replace 'corresponsding' with 'corresponding' in the comment &
> replace 'harizontal' with 'horizontal' in the comment.
> 
> Signed-off-by: Yan Zhen <yanzhen@vivo.com>

reviewed and merged to drm-intel-next.

Thanks,
Andi

