Return-Path: <linux-kernel+bounces-285905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 87CDF951418
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 08:00:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A79B31C23F76
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 06:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFB2B6F307;
	Wed, 14 Aug 2024 06:00:04 +0000 (UTC)
Received: from sonata.ens-lyon.org (domu-toccata.ens-lyon.fr [140.77.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA565FBBA
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 06:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.77.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723615204; cv=none; b=pkjy8FtRXE71EB3/rDjJppsX3caYZteu+DCQKgn3xwmexZdV53HDrqUvOJUqA1+7ARhWOPhE1liNHXtSyOc35ZNSi9l5uBZ+6ymvafRQ6xEXZNkrefioLy/ePCrom/z1kKYO9SFUTmBu873MxR8w0bsCcSOq4vV+7Xs/1laA/A8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723615204; c=relaxed/simple;
	bh=MoCIpQSOsSyGkRuE9Cv+ng65BbYT5IPL6kKQgK4qFWc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AN/lcqjZqL4jvcSWMIoXVOqGpUUw1X+vD3BZaRW1BIoN3M2+klYwfPRcQ9LBj4IGrDi/Lu/6qRVevsSrZyhTxI7bpbxuCvAz8K8bzcVq7K5a8/LAPWsDtlgO+FNGOlCqmwTuPTY6wZG+oT3I18/zJAvZCbvBmaINrqSDAsDODuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ens-lyon.org; spf=pass smtp.mailfrom=bounce.ens-lyon.org; arc=none smtp.client-ip=140.77.166.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ens-lyon.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bounce.ens-lyon.org
Received: from localhost (localhost [127.0.0.1])
	by sonata.ens-lyon.org (Postfix) with ESMTP id D580BA03A1;
	Wed, 14 Aug 2024 07:59:59 +0200 (CEST)
Received: from sonata.ens-lyon.org ([127.0.0.1])
	by localhost (sonata.ens-lyon.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id q-65m9eZU7RT; Wed, 14 Aug 2024 07:59:59 +0200 (CEST)
Received: from begin.home (apoitiers-658-1-118-253.w92-162.abo.wanadoo.fr [92.162.65.253])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by sonata.ens-lyon.org (Postfix) with ESMTPSA id 8671DA039F;
	Wed, 14 Aug 2024 07:59:56 +0200 (CEST)
Received: from samy by begin.home with local (Exim 4.98)
	(envelope-from <samuel.thibault@ens-lyon.org>)
	id 1se735-000000072Ep-3REY;
	Wed, 14 Aug 2024 07:59:55 +0200
Date: Wed, 14 Aug 2024 07:59:55 +0200
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
To: bajing <bajing@cmss.chinamobile.com>
Cc: w.d.hubbs@gmail.com, chris@the-brannons.com, kirk@reisers.ca,
	speakup@linux-speakup.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] speakup: i18n: modify incorrect comments
Message-ID: <20240814055955.4mf5idugote3pihu@begin>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
	bajing <bajing@cmss.chinamobile.com>, w.d.hubbs@gmail.com,
	chris@the-brannons.com, kirk@reisers.ca, speakup@linux-speakup.org,
	linux-kernel@vger.kernel.org
References: <20240814030017.2094-1-bajing@cmss.chinamobile.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240814030017.2094-1-bajing@cmss.chinamobile.com>
Organization: I am not organized
User-Agent: NeoMutt/20170609 (1.8.3)

bajing, le mer. 14 août 2024 11:00:17 +0800, a ecrit:
> Regarding the text part, the comment was written incorrectly, so it needs to be modified.
> 
> Signed-off-by: bajing <bajing@cmss.chinamobile.com>
> ---
>  drivers/accessibility/speakup/i18n.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/accessibility/speakup/i18n.c b/drivers/accessibility/speakup/i18n.c
> index d62079b1661f..10c7cdc685f7 100644
> --- a/drivers/accessibility/speakup/i18n.c
> +++ b/drivers/accessibility/speakup/i18n.c
> @@ -541,7 +541,7 @@ static bool fmt_validate(char *template, char *user)
>   * If the function fails, then user_messages is untouched.
>   * Arguments:
>   * - index: a message number, as found in i18n.h.
> - * - text:  text of message.  Not NUL-terminated.
> + * - text:  text of message.  Not NULL-terminated.

? Man ascii says it's called NUL, not NULL. We don't want people to
confuse it with the NULL pointer anyway, so no, we don't to change this.

Samuel

>   * - length: number of bytes in text.
>   * Failure conditions:
>   * -EINVAL -  Invalid format specifiers in formatted message or illegal index.
> -- 
> 2.33.0

