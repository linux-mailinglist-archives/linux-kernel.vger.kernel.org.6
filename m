Return-Path: <linux-kernel+bounces-285908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECF61951422
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 08:01:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77C76287474
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 06:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77E6A7345B;
	Wed, 14 Aug 2024 06:01:14 +0000 (UTC)
Received: from sonata.ens-lyon.org (domu-toccata.ens-lyon.fr [140.77.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6670349654
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 06:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.77.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723615274; cv=none; b=QA4vx2Z+vO5hucRiJbuWtNzhyGtozfiZBWgoVqgMWNBvIOo9OeudaoI1jhKU1FKqZhP0GpkF0z6FaB6XJWnXxMmnc0hH06dSmrdDx/c4RAENxWwgvms7n7k1EdUZ8odZw4jq8qdQT7+0DEJkLcnskPT6D7/p8a9OjYttRVgJ/to=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723615274; c=relaxed/simple;
	bh=JyUiIuGL811vrLgwRypRNjMAq0W0dJB5i60p3WYp9TA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FfqX1iuKpxoqOC9kYZ3J3v5D3yomB0nZntU1gNyVmE+qlUPOXXPrXhoce7oc3MJOaKlAc69weXkQnHZPsDe6pwl62kZ0DCnAw1UuDTqpcgHPvTcr1upSVBP8QOnJPK6zzYVmfwA//VDczh/igO5gGayFkm3VxCuEjbv4Gfm/zEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ens-lyon.org; spf=pass smtp.mailfrom=bounce.ens-lyon.org; arc=none smtp.client-ip=140.77.166.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ens-lyon.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bounce.ens-lyon.org
Received: from localhost (localhost [127.0.0.1])
	by sonata.ens-lyon.org (Postfix) with ESMTP id 93568A03A1;
	Wed, 14 Aug 2024 08:01:10 +0200 (CEST)
Received: from sonata.ens-lyon.org ([127.0.0.1])
	by localhost (sonata.ens-lyon.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id E1_HODT1NJdd; Wed, 14 Aug 2024 08:01:10 +0200 (CEST)
Received: from begin.home (apoitiers-658-1-118-253.w92-162.abo.wanadoo.fr [92.162.65.253])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by sonata.ens-lyon.org (Postfix) with ESMTPSA id 536CAA039F;
	Wed, 14 Aug 2024 08:01:10 +0200 (CEST)
Received: from samy by begin.home with local (Exim 4.98)
	(envelope-from <samuel.thibault@ens-lyon.org>)
	id 1se74H-000000072JD-3ON0;
	Wed, 14 Aug 2024 08:01:09 +0200
Date: Wed, 14 Aug 2024 08:01:09 +0200
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
To: bajing <bajing@cmss.chinamobile.com>
Cc: w.d.hubbs@gmail.com, chris@the-brannons.com, kirk@reisers.ca,
	nicolas@fjasle.eu, masahiroy@kernel.org, speakup@linux-speakup.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] speakup: genmap: initialization the variable
Message-ID: <20240814060109.sh34huizfjramdce@begin>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
	bajing <bajing@cmss.chinamobile.com>, w.d.hubbs@gmail.com,
	chris@the-brannons.com, kirk@reisers.ca, nicolas@fjasle.eu,
	masahiroy@kernel.org, speakup@linux-speakup.org,
	linux-kernel@vger.kernel.org
References: <20240814030243.2138-1-bajing@cmss.chinamobile.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240814030243.2138-1-bajing@cmss.chinamobile.com>
Organization: I am not organized
User-Agent: NeoMutt/20170609 (1.8.3)

bajing, le mer. 14 août 2024 11:02:43 +0800, a ecrit:
> The variable lc is not initialized before use, so the initialization operation on it is added.
> 
> Signed-off-by: bajing <bajing@cmss.chinamobile.com>
> ---
>  drivers/accessibility/speakup/genmap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/accessibility/speakup/genmap.c b/drivers/accessibility/speakup/genmap.c
> index 0882bab10fb8..a1ea0ce45c20 100644
> --- a/drivers/accessibility/speakup/genmap.c
> +++ b/drivers/accessibility/speakup/genmap.c
> @@ -48,7 +48,7 @@ static int get_shift_value(int state)
>  int
>  main(int argc, char *argv[])
>  {
> -	int value, shift_state, i, spk_val = 0, lock_val = 0;
> +	int value, shift_state, i, lc, spk_val = 0, lock_val = 0;

You have already sent a patch that does drop the use before
initialization.

Samuel

>  	int max_key_used = 0, num_keys_used = 0;
>  	struct st_key *this;
>  	struct st_key_init *p_init;
> -- 
> 2.33.0
> 
> 
> 

-- 
Samuel
 Cliquez sur le lien qui suit dans ce mail...vous n'avez plus qu'a vous
 inscrire pour gagner de l'argent en restant connecte....et puis faites
 passer le message et vous gagnerez encore plus d'argent ...
 -+- AC in NPC : Neuneu a rencontré le Pere Noël -+-

