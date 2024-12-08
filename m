Return-Path: <linux-kernel+bounces-436403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 386769E857D
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 14:35:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31D02164C24
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 13:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E281D14E2CF;
	Sun,  8 Dec 2024 13:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lpnEFWzB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4239F149C4D;
	Sun,  8 Dec 2024 13:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733664908; cv=none; b=D5QRHiu2FG9wfzCQ3VJWWZZjzuR4MB4aYtKQQyZpXo0Vs0N5HjQUZtk/H7osD+IkkwpZLt2fiRQYlX4CkLi3EDoUrPN6YLO0/If+oZN7ErJC+yqgcmX1rcPAt8jncOgxHHxA014HC1OxQIrKJtu56u4FOdrQFo9K/ittLaOOxVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733664908; c=relaxed/simple;
	bh=oYXhjhh/j3M56nqfYpwK/VSy0qJ6PGrl83ZTlbCRTzg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LXsFlQMU4L5DZeZVpxh6NFtqqbUTKPwOC12htyIpOgyJ9OmnmEun3GHPmMM8mY2OggHgk2bm/JNvmD7pRQesBUznwZS4MCveDUV2Uptftavw1VJmYADDYyAXcpDr9OY3LYVVGeke+uCYgY9h7fNcDMHJ9NrbcZDI2Q4mgavuG9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lpnEFWzB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 774D1C4CED2;
	Sun,  8 Dec 2024 13:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733664908;
	bh=oYXhjhh/j3M56nqfYpwK/VSy0qJ6PGrl83ZTlbCRTzg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lpnEFWzB9MnyWanWvzROYkGSBtvEeioE1UIIXcyZ0DerccEBxWSQt2z8mMhGfYKak
	 POMmLxSBhhFUPKS90mIrMBcfy5aJhRvznU2vuL0gzmTgIGm1EL9wI/VY9zNJCZ3GA2
	 jQuR9ENbmFKQAHF0BYJ3jb/7VPeHrBFKxEm+sDeVW+4Cgyv12NiPz6NG3pwa5Unyf1
	 TEBN4vqMP9FHGwp+NJINs+cSd0D/te7jl6T99t1rAVJcQu5voiro9SwoWFpmganhjR
	 V24S1kuZgrbJKanrsSdAIl7N2uJQUpg/5nOBDQWILzpq0Pm+06ogI8DS9A20TrFXuS
	 YbOu+I3VlgevQ==
Date: Sun, 8 Dec 2024 13:34:58 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 eraretuya@gmail.com
Subject: Re: [PATCH v5 03/10] iio: accel: adxl345: measure right-justified
Message-ID: <20241208133458.4a8428b7@jic23-huawei>
In-Reply-To: <20241205171343.308963-4-l.rubusch@gmail.com>
References: <20241205171343.308963-1-l.rubusch@gmail.com>
	<20241205171343.308963-4-l.rubusch@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  5 Dec 2024 17:13:36 +0000
Lothar Rubusch <l.rubusch@gmail.com> wrote:

> Make measurements right-justified, since it is the default for the
> driver and sensor. By not setting the ADXL345_DATA_FORMAT_JUSTIFY bit,
> the data becomes right-judstified. This was the original setting, there
> is no reason to change it to left-justified, where right-justified
> simplifies working on the registers.
> 
> Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>

I'm still confused by this one.  Does this change affect the data output
to userspace?  If seems like it definitely should. If it does we have
an ABI regression somewhere. Is it currently broken and wasn't at some
earlier stage, or is this the patch breaking things?

If it worked and currently doesn't send a fix.  If this changes a previously
working ABI then drop this patch.  Alternative being to fix up the scale
handling to incorporate this justification change.

Jonathan

> ---
>  drivers/iio/accel/adxl345_core.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
> index 88df9547bd6..98ff37271f1 100644
> --- a/drivers/iio/accel/adxl345_core.c
> +++ b/drivers/iio/accel/adxl345_core.c
> @@ -184,7 +184,6 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
>  	struct iio_dev *indio_dev;
>  	u32 regval;
>  	unsigned int data_format_mask = (ADXL345_DATA_FORMAT_RANGE |
> -					 ADXL345_DATA_FORMAT_JUSTIFY |
>  					 ADXL345_DATA_FORMAT_FULL_RES |
>  					 ADXL345_DATA_FORMAT_SELF_TEST);
>  	int ret;


