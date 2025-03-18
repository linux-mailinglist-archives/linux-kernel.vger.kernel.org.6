Return-Path: <linux-kernel+bounces-565783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36D34A66F1F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 09:56:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E959A3B5806
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 08:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EBD8204F9F;
	Tue, 18 Mar 2025 08:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mPJzoLHA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F0491F09B1;
	Tue, 18 Mar 2025 08:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742288152; cv=none; b=hvZl+NL6JDkXdBF/rek68jX8OuSr2l2r7eTiAHQ/sicyc3wLVBegDlsUmOcfrPzN6qw5/mN1CBRXfbmiUrw5wa02mNXUtlREF1PIjuPGSYlxwi7I1P/7/wgtiJXbbLs6/RemnBB+eWqTf9k57H+6vBsKxH/GjVRb88lngBmnhe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742288152; c=relaxed/simple;
	bh=cENHEfBwksetLOQ9Qvuf1qiHYnKO+mYNedIf1arVU3w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ev5z7LY7LZLu3xs38t/OeqZy+fYxBa/CIYXKBXKPDusLE/WnR4yAYdylToj+yp/Ga7rbujDWQB1TyV87DoUaO4EE9UwTtPQOyEUoXniI/y6kPQY9YR+KcXP2F8vLeOu4RkW9n7x8Q8qHnvBA3pdfeh13Ut4wErcLun9an+B53MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mPJzoLHA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46E6FC4CEDD;
	Tue, 18 Mar 2025 08:55:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742288152;
	bh=cENHEfBwksetLOQ9Qvuf1qiHYnKO+mYNedIf1arVU3w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mPJzoLHAe1KrYEsDclnKogknIkT6YOt8k+mz6Z0G5zjil0bQhjmb8d2QUIXsQwSjs
	 EJPLa1LEHhPSwSN8KPzOhuc5ZqiN0WmvBMW8UgSphPdWc0P5P8vaWmapTsS1mzWITV
	 73Kr7FQfJyJIJgUTCWBnJCWwEDNxj1ptrwH+YZ++JYazeCTSrEG9ig1RxKOCu/DcAJ
	 SSPqLZdUwA3nNNYttAJTkzim32AyVFTqNHu8Q4SVnCUvbGiiZhUaPAAGiI2hq/cLaH
	 JJGv12agVXPlKWfDc0nzI7XsmpyBZqadZeF2UQRSYF9GJnzkvkVqtM63RU9OQ6oFnz
	 lENpF2x+J7+MQ==
Date: Tue, 18 Mar 2025 09:55:48 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: cy_huang@richtek.com
Cc: Mark Brown <broonie@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Tzung-Bi Shih <tzungbi@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
	Otto Lin <otto_lin@richtek.com>, Allen Lin <allen_lin@richtek.com>, linux-sound@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: dt-bindings: maxim,max98357a: Add compatible with
 richtek,rt9123
Message-ID: <20250318-mature-dogfish-of-ecstasy-3dcea5@krzk-bin>
References: <1884c3ce2d901ead5d742958889f5a742e168376.1742259040.git.cy_huang@richtek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1884c3ce2d901ead5d742958889f5a742e168376.1742259040.git.cy_huang@richtek.com>

On Tue, Mar 18, 2025 at 08:57:51AM +0800, cy_huang@richtek.com wrote:
> From: ChiYuan Huang <cy_huang@richtek.com>
> 
> The hardware control and specification of 'richtek,rt9123' are similar
> with max98357 or max98360. It's no need to add the new source code. So

Are you sure? I looked at datasheet and do not see anything about
SD_MODE in RT9123. Also you have two supplies, while max98360a has only
one. You have I2C but max98360a has no.

These devices do not look compatible.

Best regards,
Krzysztof


