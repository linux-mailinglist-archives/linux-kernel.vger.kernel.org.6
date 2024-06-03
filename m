Return-Path: <linux-kernel+bounces-199452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19B588D875F
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 18:37:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C895328A0C4
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 16:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 318E9136674;
	Mon,  3 Jun 2024 16:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="IQ3YWtlu"
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 752D27E8
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 16:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.134.164.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717432649; cv=none; b=oas8Q2Ul5OQI4g5Zmpa1oITA8H31ncJxPX58TqrycBSs5H4vKmquDk28kXvxTQN3sjPY+VPkAJ1cXDbgq68yPCVq9gZOebNzKK1t61UFRuqki1AJPVplHTe9MB09xVI0Ujla/7ZBTDVIcNUsO3GNrhJoCKmyokRpz8H1yiZ9s7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717432649; c=relaxed/simple;
	bh=TIb7j5QgHLOHbyD3iLQ52ZT/GFl+mYp9eWgpKEUfaMY=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=SrLyOG16w/2itXxN8z8yFo62kUNAc//oK1o9Mj4HDXLOUh18I7c0VvA5NbrUG0/XmlP1RxIZcJJKvCOS33HG89MQsJSKiaRnEGP3ctZwfVQVX0cbjm9yzaR+bViousNNH1dSFtfqCFVsmr12VOpKrQftSP6Sop80pj+DOX2qrGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr; spf=pass smtp.mailfrom=inria.fr; dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b=IQ3YWtlu; arc=none smtp.client-ip=192.134.164.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=zqP9S4nbMBeYlOfeJab+B5j1vuo4Z8qBfN99sVGKJkU=;
  b=IQ3YWtluCXBYIvyU71GLgHBfJJOmMIvU9vb/vtTu4PqLjlOR/hOsptEE
   NsvezDG3Mw0gignZUfbFJelCDqiwRy9LNyq7oYUnvM0WLDsURql4mcuY/
   PDSVs/mIVRCFh7o009U7Faf8ADNzTEp+nd8eZ3ebPI0XGfgoou0mwc3/0
   M=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.08,212,1712613600"; 
   d="scan'208";a="88703209"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2024 18:37:17 +0200
Date: Mon, 3 Jun 2024 18:37:17 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Thorsten Blum <thorsten.blum@toblux.com>
cc: nicolas.palix@imag.fr, cocci@inria.fr, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scripts: coccicheck: Replace http with https
In-Reply-To: <20240603155648.93989-1-thorsten.blum@toblux.com>
Message-ID: <4bc15f4-d93e-8c84-41d3-7fdc8c1117ba@inria.fr>
References: <20240603155648.93989-1-thorsten.blum@toblux.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Mon, 3 Jun 2024, Thorsten Blum wrote:

> The Coccinelle website is also available via https.

Thanks for the suggestion, but that link is actually completely out of
date.  I will change it to the correct one.

julia

>
> Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
> ---
>  scripts/coccicheck | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/scripts/coccicheck b/scripts/coccicheck
> index e52cb43fede6..9b6b29fb8224 100755
> --- a/scripts/coccicheck
> +++ b/scripts/coccicheck
> @@ -11,7 +11,7 @@ DIR="$(dirname $(readlink -f $0))/.."
>  SPATCH="`which ${SPATCH:=spatch}`"
>
>  if [ ! -x "$SPATCH" ]; then
> -    echo 'spatch is part of the Coccinelle project and is available at http://coccinelle.lip6.fr/'
> +    echo 'spatch is part of the Coccinelle project and is available at https://coccinelle.lip6.fr/'
>      exit 1
>  fi
>
> @@ -233,7 +233,7 @@ coccinelle () {
>  	echo " in $FILE."
>  	echo ''
>  	echo ' More information about semantic patching is available at'
> -	echo ' http://coccinelle.lip6.fr/'
> +	echo ' https://coccinelle.lip6.fr/'
>  	echo ''
>
>  	if [ "`sed -ne 's|^//#||p' $COCCI`" ] ; then
> --
> 2.39.2
>
>

