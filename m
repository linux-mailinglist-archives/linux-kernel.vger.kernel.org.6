Return-Path: <linux-kernel+bounces-559477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96CA7A5F43C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 13:25:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8063119C2162
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 12:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F200D2673A2;
	Thu, 13 Mar 2025 12:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="EbCTWpuC"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE9D266B40
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 12:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741868689; cv=none; b=eBlMbSOo8RjmCJK4LKRu4JMisg5N2C+u3XnfA9PIMzYFH92ed0i8fAQ75ACAHvzZIpfN1bPOoKbK2ln5emDy6kpwz1hNGLvtIj+xRx9RRKd2PfjIUEvbXjd1Vao+rxiZyhrl2r+GZewYVoiETg+9vOLrsJ3vG7z98yQO4D/2jQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741868689; c=relaxed/simple;
	bh=qUINEFrGdyqtUCxJgPIIWVSKNSceW/vG2w99VTb0EFQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ED9dBLNIJ8PbLGpCPluACzWp2pG4c/MDJvVzREIrNxAm0UPrO3DldDp9jccXjIOyw9uXBCh2VJtdwdrDaTwDLrsg/0IX1z1pTwmF1Rg0BGmM2N7ueoSFXIETTH42LMo2wvjTzag93BpHJAp8/IFpbBn/vf6h1E6c0Bwo7selWqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=EbCTWpuC; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3913b539aabso549719f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 05:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1741868684; x=1742473484; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jdwK1Zh8ZZo6rwDf542VaxRAlTlQ9sZFdzOTXwzDIRU=;
        b=EbCTWpuCIEVmrusg4jm7PmZ3G9kQr3/k9FBQmvZQ8D7L9OQ+iISsTbF2CI9I7Bi7gG
         bkXR4Csa9wQus0Wn3s8RDbygCrSwQoxc0zR4YNMOspJKsGE+qogTlrrQv4/JIgdiLaQC
         srHIzpaxhUnaPIR/rbJblHFnLgfoenOWhKitdtVdX6uHq24OQ/Jk8asZPuloMdH88Gcb
         PwABAp+AOU8lCJ61EKwfQlNMR9F8nIEIwMFNi4vwTZIMkosSsHDu5x3I0O/zvJuFQpZQ
         CTaTAXGf8EJm2gSbBuYUb4oq4aKf0bSHvrfQou7r10dsjUH3wz5o/1X0jX53FbeEL0Ws
         caHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741868684; x=1742473484;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jdwK1Zh8ZZo6rwDf542VaxRAlTlQ9sZFdzOTXwzDIRU=;
        b=kEBsav4r7igdycwyk8zFvpc0GE4Ntp7ap1SF3B8WRy38cNZ2SbWr/KpdAZPUWXpkVr
         xky3oBFIf+EybsByG6mX8/93uDUPtTHwn3PNNj9XbBb/EVmrOiijaLlosvW1T7SZ8rZh
         GRgALArNRrqAiAoHIVrxBE1YaL5zh53TajTr7KgpZ2up2fOa3DDvBhBD8dGnie34Vrgx
         ErN9cz2aEO06gxDKh787o8+0y7BCapdTt+kxHgWRVAB8RflqBkS4lMbg/0WqY2a+2XNJ
         8cuSbWRJh9fUr4i2ZtaN09wggdenCOXJbIwaEVp6csB51IA5ESQIaoEhxKjp7wcao4RG
         1AXQ==
X-Forwarded-Encrypted: i=1; AJvYcCW7vypkQIxVzJnUml9z19xVsiUIHqt0XMKstiY6K/ILoSgtpFAmcgskYqX+nBtXx4WVNfTpaZxNtqKb2ss=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy20FkvOtyCkXmawi1GYG2toSNmsCaBOy9WejaoCYf7Wx0lXxZO
	OwHwE+cqMjqGSv6X2pjAaa/7xSGkDQmv6tylkOw0S4p+O7gC9Zh2VJekNdZ29yU=
X-Gm-Gg: ASbGncudWJHC6bxw7xfE6uDtLU64xEKo1kYiBcSgsgRoxTtszxcGKDb9exutSsSHnCH
	WqlzGmSA+ZWjOVuJQm5tO2gtJTCQXpcOa7ONbKKRzVk7K+lnU3D+DrnRiGhleTFLlTJPUQoV9C8
	5g3Di1Q8OpZ5epUCgMUbUFj5wZ/VOL7bsC5H4hhzKrNvhPa5sfCpQtmn0AW0nwkABLtjvzeoZpq
	PsiSP/dG4nxRu0MiZdTE+iKd+odqNiFh5ijgkWEqhRFBNk0C/O6jHD1Y0NYFv5jjTRuDjFzUgpj
	DnNFQwCjLGBMsSjjkA79NFunVg/nnoAv
X-Google-Smtp-Source: AGHT+IHTTFdUMyPE8J6/FJ/Tz2TmgEnvUPiqAP3Vg4LJA9U623EyzHKoPA3QMg0KCVbZ9Z4v0fkfMA==
X-Received: by 2002:a05:6000:402a:b0:390:e5c6:920 with SMTP id ffacd0b85a97d-39132d22aa7mr18761264f8f.3.1741868684583;
        Thu, 13 Mar 2025 05:24:44 -0700 (PDT)
Received: from localhost ([2a02:8308:a00c:e200::59a5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c8975b90sm2006325f8f.53.2025.03.13.05.24.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 05:24:44 -0700 (PDT)
Date: Thu, 13 Mar 2025 13:24:43 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: =?utf-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Anup Patel <anup@brainfault.org>, 
	Atish Patra <atishp@atishpatra.org>, Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, linux-kselftest@vger.kernel.org, 
	Samuel Holland <samuel.holland@sifive.com>, Deepak Gupta <debug@rivosinc.com>
Subject: Re: [PATCH v3 01/17] riscv: add Firmware Feature (FWFT) SBI
 extensions definitions
Message-ID: <20250313-924c6711597160f50c4cf90e@orel>
References: <20250310151229.2365992-1-cleger@rivosinc.com>
 <20250310151229.2365992-2-cleger@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250310151229.2365992-2-cleger@rivosinc.com>

On Mon, Mar 10, 2025 at 04:12:08PM +0100, Clément Léger wrote:
> The Firmware Features extension (FWFT) was added as part of the SBI 3.0
> specification. Add SBI definitions to use this extension.
> 
> Signed-off-by: Clément Léger <cleger@rivosinc.com>
> Reviewed-by: Samuel Holland <samuel.holland@sifive.com>
> Tested-by: Samuel Holland <samuel.holland@sifive.com>
> Reviewed-by: Deepak Gupta <debug@rivosinc.com>
> ---
>  arch/riscv/include/asm/sbi.h | 33 +++++++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

