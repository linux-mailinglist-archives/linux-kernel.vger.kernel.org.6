Return-Path: <linux-kernel+bounces-213319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FB709073B0
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 15:29:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 655481C24362
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 13:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96C9D144317;
	Thu, 13 Jun 2024 13:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="hEr0vpCb"
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53DC1A94D;
	Thu, 13 Jun 2024 13:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718285340; cv=none; b=A8/0X4kT4dgq2U2/B/NcGPdQZ8EAjCZYBrKULQ7cFZInx4yUuHVr2JUhpCTfFYAsgHrb+0ArJJp60IiEBZ7rD4j+3QgGKhnbGVkxm55p6c3dU/Cn1LjJOiscU+C4BDVyEMiLWbxmnTfDUfVExG5UpRt8KSkvn9JHuedEABlJPW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718285340; c=relaxed/simple;
	bh=M403i1wr03iFxSd5oZuZ47XjBAqlOdDgajGkG8jLGws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JJ5M7AtIJ2U2JqbITv43fzRPeNIcbb5mScERGdFlTVa1DB6HaF2mWsclUekw25hbOZ0yWjzIe2N4B1XRiMPTbNeojhohA1GizHJhr5EjbJ1Ehat5fFDK3HCd4iy4L61U/MCvpWJnvwKFidSzjFp7e4wJ1q6MNzo7Eegce5T24Gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=hEr0vpCb; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=Aw2UpRrb/0IRX1nWbi9uNr4uEqnfOdv5VXfHN4te1L0=; b=hEr0vpCbWOHz/J+z
	+k0p0caJpTQx7IMpqg+C3MWqwiHA9TNK89ikZc4sB4js4JjRVAorgP4MlgM62J0DbOb/ML7+fddic
	NuGK/F/+eOH4rgyckM7xu5nRMxjiXeYSJ0/aYR0KH4GDxSyGc+VdVUF0M1gUCzS+aTmNjtzA/do2S
	OkM5hDTnORr9hyB+CUqv9OxrxhNOP9KTyd4idDdr95/3WPevSxRwwq+1ffCTNZxe7l0ibaBrsBa1A
	cumxpA+CqXVXmqhY1nilgsgzG0pufuL5G10c7pJTKgphkN34UqDjLwall+Un1fSVUwwYlBgLmIpDf
	v8RH1iVywx3mPROZ7w==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1sHkVd-0062bu-0M;
	Thu, 13 Jun 2024 13:28:57 +0000
Date: Thu, 13 Jun 2024 13:28:57 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: johan@kernel.org, gregkh@linuxfoundation.org
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB: serial: spcp8x5: remove unused struct
 'spcp8x5_usb_ctrl_arg'
Message-ID: <Zmr0GV57EGwxcYeM@gallifrey>
References: <20240529234722.130609-1-linux@treblig.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20240529234722.130609-1-linux@treblig.org>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 13:28:39 up 36 days, 42 min,  1 user,  load average: 0.08, 0.08,
 0.02
User-Agent: Mutt/2.2.12 (2023-09-09)

* linux@treblig.org (linux@treblig.org) wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> 'spcp8x5_usb_ctrl_arg' has been unused since the original
> commit 619a6f1d1423 ("USB: add usb-serial spcp8x5 driver").
> 
> Remove it.
> 
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>

Ping?

Dave

> ---
>  drivers/usb/serial/spcp8x5.c | 10 ----------
>  1 file changed, 10 deletions(-)
> 
> diff --git a/drivers/usb/serial/spcp8x5.c b/drivers/usb/serial/spcp8x5.c
> index 09a972a838ee..6b294bf8bc43 100644
> --- a/drivers/usb/serial/spcp8x5.c
> +++ b/drivers/usb/serial/spcp8x5.c
> @@ -49,16 +49,6 @@ static const struct usb_device_id id_table[] = {
>  };
>  MODULE_DEVICE_TABLE(usb, id_table);
>  
> -struct spcp8x5_usb_ctrl_arg {
> -	u8	type;
> -	u8	cmd;
> -	u8	cmd_type;
> -	u16	value;
> -	u16	index;
> -	u16	length;
> -};
> -
> -
>  /* spcp8x5 spec register define */
>  #define MCR_CONTROL_LINE_RTS		0x02
>  #define MCR_CONTROL_LINE_DTR		0x01
> -- 
> 2.45.1
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

