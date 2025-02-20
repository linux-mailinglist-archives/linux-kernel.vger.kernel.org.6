Return-Path: <linux-kernel+bounces-523229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2657A3D3C5
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 09:54:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CF20178437
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 08:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F03F1EBA19;
	Thu, 20 Feb 2025 08:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=aruba.it header.i=@aruba.it header.b="QQDegFOH"
Received: from smtpcmd04131.aruba.it (smtpcmd04131.aruba.it [62.149.158.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D60B1DF962
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 08:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.149.158.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740041642; cv=none; b=rp3A4xtw6z1VvMmlsPhlzSUrNZt+XWJl5rKv87+iQ+yfuLhLmkgJv9R4FIdkWEeUvC/5PhVqPpQVltuocmNfRwrNt2pG3sEAyQgei/u0mU04zE0u5H9Cy/PWR7zZk6G5oDRU8ix7weS7+2FDFWNQ6EIEp5upLQcIhNR/2kMMuRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740041642; c=relaxed/simple;
	bh=XuOt+k7infwBUHF3nbx0V8CBRyv2oIpW4kehDoGXnio=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mtT3d7ugIQEMJ86PGAtNwotYfqCDWHj8QqH7LPZ+sSpBWZgOb1DQ9xXT3lsPr8A3exoZz1DVwk7FAvfJnk9Sy3tszPWjIW6R8B2vROjCPrOydMxNj56HcY9WAQeDQADhVwwJsBpcledtrivApZ1d2Yvb5dDENbOi7VmiN4g6bY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enneenne.com; spf=pass smtp.mailfrom=enneenne.com; dkim=temperror (0-bit key) header.d=aruba.it header.i=@aruba.it header.b=QQDegFOH; arc=none smtp.client-ip=62.149.158.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enneenne.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enneenne.com
Received: from [192.168.1.58] ([79.0.204.227])
	by Aruba SMTP with ESMTPSA
	id l2GdtGXxnNbHHl2GdtlZWI; Thu, 20 Feb 2025 09:50:47 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
	t=1740041448; bh=XuOt+k7infwBUHF3nbx0V8CBRyv2oIpW4kehDoGXnio=;
	h=Date:MIME-Version:Subject:To:From:Content-Type;
	b=QQDegFOHVp20GrejgTCum3ViPreexgGdukQbxPPXaUZmkngx4Y9NhH4q8XbM76zNF
	 GR8uHiVHtB0KlxlRCtrxulKQ8IdOvTDOIr6zFLw9atFB95DipH6YZ6J6RsUKewM/v8
	 LZOBDaPHRxykIGvEd+a7YB0EwrX/yuDKy9LFRDhxDn7x2QTXeWC+5N6kASXAvcABCw
	 /Cz3xwpYgMZpeKyX69UWNzsxMWu8JvavKqr1gPTH32sUkciRcFbCB3VRn3ijSE/q1E
	 PgwrNc/1fxn2vQoQh7i9m3hWXqhcSOdMKRy/U4sMFqZIgp0QjJq4GRJpGD5yDa0De3
	 4jF7NxbDUNjYA==
Message-ID: <09e91710-c1db-415f-b010-b27a3712fb13@enneenne.com>
Date: Thu, 20 Feb 2025 09:50:46 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pps: add epoll support
Content-Language: en-US
To: Denis OSTERLAND-HEIM <denis.osterland@diehl.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <8baae1732dfc47759687e7537cac57ad@diehl.com>
From: Rodolfo Giometti <giometti@enneenne.com>
In-Reply-To: <8baae1732dfc47759687e7537cac57ad@diehl.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfJkqNFgmTrUV6ekjrwxRDk7omiBdkidDVM49+QJ/uv6VrrZEYNi2WvOL/YY0Eg95z8B1Wewzwcd2HfibqaspZ65MkSXNr3arRH7VaUK/P5Vy7RpBawAT
 UbfkEah81df4Tu/MhBW/lBJmy6MxfrcSMqCsEkxms4ADNQVZh4pG/RzXxSOTsK85wPIs68AQIHoqH6WQaCI0y7yKncDMMOAfM9dJ71dK10C+vqKxT72F1o/o
 z2LEcVpn1boqr0bEeOfx1Q==

On 19/02/25 13:21, Denis OSTERLAND-HEIM wrote:
> Gentle ping
> 
> -----Original Message-----
> From: Denis OSTERLAND-HEIM
> Sent: Monday, January 20, 2025 2:11 PM
> To: 'Rodolfo Giometti' <giometti@enneenne.com>
> Cc: linux-kernel@vger.kernel.org
> Subject: [PATCH] pps: add epoll support
> 
> This patch adds pps_context to store the per file read counter.

Can you explain it a bit better?

RFC2783 states that to access to PPS timestamps we should use the 
time_pps_fetch() function, where we may read:

3.4.3 New functions: access to PPS timestamps

    The API includes one function that gives applications access to PPS
    timestamps.  As an implementation option, the application may request
    the API to block until the next timestamp is captured.  (The API does
    not directly support the use of the select() or poll() system calls
    to wait for PPS events.)

How do you think to use this new select()/poll() support without breaking the 
RFC2783 compliance?

Also, if we decide to add this support, we should also consider adding the 
PPS_CANPOLL mode bit definition (see 
https://www.rfc-editor.org/rfc/rfc2783.html#section-3.3), and proving proper 
code in order to show how we can use or not this new functionality.

> Signed-off-by: Denis Osterland-Heim <denis.osterland@diehl.com>
> ---
>   drivers/pps/pps.c | 33 ++++++++++++++++++++++++++-------
>   1 file changed, 26 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/pps/pps.c b/drivers/pps/pps.c
> index 25d47907db17..b5834c592e2a 100644
> --- a/drivers/pps/pps.c
> +++ b/drivers/pps/pps.c
> @@ -21,6 +21,12 @@
>   
>   #include "kc.h"
>   
> +struct pps_context {
> +	struct pps_device *pps;
> +	unsigned int ev;
> +};
> +
> +
>   /*
>    * Local variables
>    */
> @@ -37,17 +43,19 @@ static DEFINE_IDR(pps_idr);
>   
>   static __poll_t pps_cdev_poll(struct file *file, poll_table *wait)
>   {
> -	struct pps_device *pps = file->private_data;
> +	struct pps_context *ctx = file->private_data;
> +	struct pps_device *pps = ctx->pps;
>   
>   	poll_wait(file, &pps->queue, wait);
>   
> -	return EPOLLIN | EPOLLRDNORM;
> +	return (ctx->ev != pps->last_ev) ? (EPOLLIN | EPOLLRDNORM) : 0;
>   }
>   
>   static int pps_cdev_fasync(int fd, struct file *file, int on)
>   {
> -	struct pps_device *pps = file->private_data;
> -	return fasync_helper(fd, file, on, &pps->async_queue);
> +	struct pps_context *ctx = file->private_data;
> +
> +	return fasync_helper(fd, file, on, &ctx->pps->async_queue);
>   }
>   
>   static int pps_cdev_pps_fetch(struct pps_device *pps, struct pps_fdata *fdata)
> @@ -90,7 +98,8 @@ static int pps_cdev_pps_fetch(struct pps_device *pps, struct pps_fdata *fdata)
>   static long pps_cdev_ioctl(struct file *file,
>   		unsigned int cmd, unsigned long arg)
>   {
> -	struct pps_device *pps = file->private_data;
> +	struct pps_context *ctx = file->private_data;
> +	struct pps_device *pps = ctx->pps;
>   	struct pps_kparams params;
>   	void __user *uarg = (void __user *) arg;
>   	int __user *iuarg = (int __user *) arg;
> @@ -189,6 +198,7 @@ static long pps_cdev_ioctl(struct file *file,
>   		/* Return the fetched timestamp */
>   		spin_lock_irq(&pps->lock);
>   
> +		ctx->ev = pps->last_ev;
>   		fdata.info.assert_sequence = pps->assert_sequence;
>   		fdata.info.clear_sequence = pps->clear_sequence;
>   		fdata.info.assert_tu = pps->assert_tu;
> @@ -249,7 +259,8 @@ static long pps_cdev_ioctl(struct file *file,
>   static long pps_cdev_compat_ioctl(struct file *file,
>   		unsigned int cmd, unsigned long arg)
>   {
> -	struct pps_device *pps = file->private_data;
> +	struct pps_context *ctx = file->private_data;
> +	struct pps_device *pps = ctx->pps;
>   	void __user *uarg = (void __user *) arg;
>   
>   	cmd = _IOC(_IOC_DIR(cmd), _IOC_TYPE(cmd), _IOC_NR(cmd), sizeof(void *));
> @@ -275,6 +286,7 @@ static long pps_cdev_compat_ioctl(struct file *file,
>   		/* Return the fetched timestamp */
>   		spin_lock_irq(&pps->lock);
>   
> +		ctx->ev = pps->last_ev;
>   		compat.info.assert_sequence = pps->assert_sequence;
>   		compat.info.clear_sequence = pps->clear_sequence;
>   		compat.info.current_mode = pps->current_mode;
> @@ -300,7 +312,13 @@ static int pps_cdev_open(struct inode *inode, struct file *file)
>   {
>   	struct pps_device *pps = container_of(inode->i_cdev,
>   						struct pps_device, cdev);
> -	file->private_data = pps;
> +	struct pps_context *ctx = kzalloc(sizeof(struct pps_context), GFP_KERNEL);
> +
> +	if (unlikely(ZERO_OR_NULL_PTR(ctx)))
> +		return -ENOMEM;
> +	file->private_data = ctx;
> +	ctx->pps = pps;
> +	ctx->ev = pps->last_ev;

Doing so, we always miss the first event... maybe can we drop this setting and 
leaving ctx->ev set to zero?

>   	kobject_get(&pps->dev->kobj);
>   	return 0;
>   }
> @@ -309,6 +327,7 @@ static int pps_cdev_release(struct inode *inode, struct file *file)
>   {
>   	struct pps_device *pps = container_of(inode->i_cdev,
>   						struct pps_device, cdev);
> +	kfree(file->private_data);
>   	kobject_put(&pps->dev->kobj);
>   	return 0;
>   }

Ciao,

Rodolfo

-- 
GNU/Linux Solutions                  e-mail: giometti@enneenne.com
Linux Device Driver                          giometti@linux.it
Embedded Systems                     phone:  +39 349 2432127
UNIX programming


