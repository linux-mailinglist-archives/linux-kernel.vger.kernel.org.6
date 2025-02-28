Return-Path: <linux-kernel+bounces-537974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3810EA4931E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 09:14:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C33A8188ED5A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 08:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7A2721481D;
	Fri, 28 Feb 2025 08:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q7lAFXMe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 334C12144A7
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 08:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740730450; cv=none; b=gc+jbsjWlOqRMdCf6Fa0GE0DPX5Rno8kn6bDsWZV1vw5jD10WsX978pl64porOgnDbtpcWDe6zVeWV3B0NF8yQsdwI1TTKGjKg4dgM0litWf0FeYn7tEIYRVYj5iUCtT+8dxRrHU1ryn26YsW913jfo3d6Pwrcp/9jTnV1pgjxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740730450; c=relaxed/simple;
	bh=ySlH8cwUfgxAHrET1qkMdS1CVUGRJVYMa3a+y3kimvU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CAVQ2Yc+amhCy9XTCkyvijcwT8x1/EPaEMlToDwsvz6rX9wL80eUxoCxlBTAWOeQwK4WvfrM7d7HHHVsaZVVPZnbUKInW5KVuvYqC54WJjbivpLAddXqNlD4GkPIkqTayoIm9XCOSla4r8Ob7YL84Ocwi67nvSLIp3kenpqMPbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q7lAFXMe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 107E5C4CEE5;
	Fri, 28 Feb 2025 08:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740730449;
	bh=ySlH8cwUfgxAHrET1qkMdS1CVUGRJVYMa3a+y3kimvU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=q7lAFXMe/vv6DLfM69JppnGMpPaHjjlNoSnz2LztMZjEJQQTNzclf0qPBfiI7iziv
	 Rtz7DhFEoK/t8CYqIIttzXonSoLOrF0KMkdKB9LJpY8QMgNhG9nUkZGk5mU+RKhOba
	 m6+5cR5IB6H7fhOSWUO00b9J6PqOwlJdvOjb/rquaIQgHEGwWJcIAkasDIeUENOYZo
	 dAM0QinCLtNCmRWRFyyCHI4L4JZIhMKMFjR6HxfvpDehcOBhTO0JGv6c8Qvoj3eJix
	 33bzdvv3zv9DcZk6klmxRG4qQSlSl6GC2FpUbVtH9L4laKs7TrHibcUPxM9eaoeFq6
	 B7lRp6CFy5i2g==
Date: Fri, 28 Feb 2025 08:14:06 +0000
From: Lee Jones <lee@kernel.org>
To: webgeek1234@gmail.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: max77620: Allow building as a module
Message-ID: <20250228081406.GL824852@google.com>
References: <20250224-max77620-module-v1-1-96eb22e9f266@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250224-max77620-module-v1-1-96eb22e9f266@gmail.com>

On Mon, 24 Feb 2025, Aaron Kling via B4 Relay wrote:

> From: Aaron Kling <webgeek1234@gmail.com>
> 
> The driver works fine as a module, so allowing building as such.
> 
> Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
> ---
>  drivers/mfd/Kconfig    | 2 +-
>  drivers/mfd/max77620.c | 4 ++++
>  2 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index 6b0682af6e32b434ee3e99940005a6cce14ff55c..922704bd0ce3fe6c094da6b1528b72fedcfa1677 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -858,7 +858,7 @@ config MFD_MAX77541
>  	  There are regulators and adc.
>  
>  config MFD_MAX77620
> -	bool "Maxim Semiconductor MAX77620 and MAX20024 PMIC Support"
> +	tristate "Maxim Semiconductor MAX77620 and MAX20024 PMIC Support"
>  	depends on I2C=y
>  	depends on OF
>  	select MFD_CORE
> diff --git a/drivers/mfd/max77620.c b/drivers/mfd/max77620.c
> index 89b30ef91f4f112b06e0e055e75e480fab176f8f..10264fce95a4a37f22f205edbf364fa6783e35dd 100644
> --- a/drivers/mfd/max77620.c
> +++ b/drivers/mfd/max77620.c

#include <linux/module.h>

> @@ -700,3 +700,7 @@ static struct i2c_driver max77620_driver = {
>  	.id_table = max77620_id,
>  };
>  builtin_i2c_driver(max77620_driver);
> +
> +MODULE_DESCRIPTION("Maxim Semiconductor MAX77620 and MAX20024 PMIC Support");
> +MODULE_AUTHOR("Laxman Dewangan <ldewangan@nvidia.com>");
> +MODULE_LICENSE("GPL");
> 
> ---
> base-commit: d082ecbc71e9e0bf49883ee4afd435a77a5101b6
> change-id: 20250224-max77620-module-84bee019b0a9
> 
> Best regards,
> -- 
> Aaron Kling <webgeek1234@gmail.com>
> 
> 

-- 
Lee Jones [李琼斯]

