Return-Path: <linux-kernel+bounces-265390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E41193F08A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 11:00:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DC671C22082
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 09:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C239313D890;
	Mon, 29 Jul 2024 08:59:55 +0000 (UTC)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBE2813D61A
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 08:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722243595; cv=none; b=bFEdGkphiS3+dor3uiD1T1XdSJh+/EmPqDLAs5mpHigGW3eJqFQ5YeX2tnQW2srPuaNLcySsbgER/2sEQUCAGP8+gp42Cgu4c5tLT0bmYj9lhECFOCf9EY2Vz/GDd+11/aZOPA5GocPwJ5Itfso6GlLPx2j1BT5w+PmN6Ib1KjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722243595; c=relaxed/simple;
	bh=hqP6sq1/siyRJmm9dsWrEVc2i6yocHnZtpXtRLDSdZc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jjGjyI3olGU3nN44AgVVESBx1fJlw4lEyiP6VawraTxVLJaMK+Rk/AwNGx9xxiX44nO7jsEe2ESNePEnmkAA4LSwutRM0/TnG/lGkhckZrEli/BDKOBmpHw1g9YfYsbhSqPJWfLd75YwL1XKUKEoL+OWBGoI/6gLCgylV+6jHBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-52efaae7edfso3511848e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 01:59:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722243592; x=1722848392;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Btq8WMKjgNpVVLDFTZNgyEl08+t6K7ENAhPfv6Aq530=;
        b=BGrJxrZsNX8D+i4XZAyLs4ZM9w2CWF2d/t1yUZ4Ki3JLDqLYQNnMaxBwbvNsiF3fry
         P5wqJWqjkv9g1YZlwBf1EmoRSHxUm6awLOxu5OzWy9QWojiUJCSp0SmzFXBp/5T4WPCf
         jBdY2IKfDR75xoMBTjDnwZV3OcMrvaEYLGmMb4S7IpXyKcV5WfZMpVap71t/3xomfwO4
         gRBgTLnXmdYnEFMPALtDIBXow/v8rZ0NVXafPln1ZB0AVSiwrFgPjAOb0IYMhTnUAPoB
         o3Ji8g3gt97dN1BmQ/8LEmEFxcgKKHW9J24Enl5kAqkMkfkAxgpsb9lKTWZAj8FDqFjy
         QMoA==
X-Forwarded-Encrypted: i=1; AJvYcCWT96QhRG5PhAWQ8S504YizD4LdwYGntUFAyt67HDniGM/oeeqsds97e0eGHZE000yN1bEf3BOWyipxy+cVI5YnhiylNyPlxO2Fvy7A
X-Gm-Message-State: AOJu0Yz/Ffq9ynvXDWjta/3OoRMussyU6068E/VhdxkVu+6DziEyILpU
	gbIgn0weOF97J4ujH9ZtM+pLzK8pCe+u3uv77M3Vc7ZddimkG59FGYga6g==
X-Google-Smtp-Source: AGHT+IF+4IAf7BzBLdUo0RNHSy7X2NfHyL8QoPDcZSgA1EY8OEN8n+wJjXXBN5taC2c3aCr6mO5BZg==
X-Received: by 2002:a05:6512:4009:b0:52c:88d7:ae31 with SMTP id 2adb3069b0e04-5309b2c361amr4694182e87.48.1722243591329;
        Mon, 29 Jul 2024 01:59:51 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-001.fbsv.net. [2a03:2880:30ff:1::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acac615c0sm478657466b.97.2024.07.29.01.59.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 01:59:50 -0700 (PDT)
Date: Mon, 29 Jul 2024 01:59:46 -0700
From: Breno Leitao <leitao@debian.org>
To: Akinobu Mita <akinobu.mita@gmail.com>
Cc: akpm@linux-foundation.org, leit@meta.com,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fault-injection: Enhance failcmd to exit on non-hex
 address input
Message-ID: <ZqdaAn0s8J3fZ15u@gmail.com>
References: <20240726104848.2756962-1-leitao@debian.org>
 <CAC5umygxnq=h1H2CCeprzaggu_A4DxZia3EEBTYk7sb72OnQFA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAC5umygxnq=h1H2CCeprzaggu_A4DxZia3EEBTYk7sb72OnQFA@mail.gmail.com>

Hello Akinobu,

On Sun, Jul 28, 2024 at 06:00:14PM +0900, Akinobu Mita wrote:
> 2024年7月26日(金) 19:50 Breno Leitao <leitao@debian.org>:

> > +exit_if_not_hex() {
> > +    local value="$1"
> > +    if ! [[ $value =~ ^0x[0-9a-fA-F]+$ ]]; then
> > +        echo "Error: The provided value '$value' is not a valid hexadecimal number."
> 
> It is better to write error messages to standard error rather than
> standard output.

Agree. I've sent a V2 with your proposed change. Thanks!

> Other than that I think it's good.

Thanks.

By the way, this file seems unmaintained by looking at MAINTAINERS.
Would you mind if I send something as:


Author: Breno Leitao <leitao@debian.org>
Date:   Mon Jul 29 01:53:44 2024 -0700

    failcmd: Add script file in MAINTAINERS
    
    failcmd is one of the main interfaces to fault injection framework, but,
    it is not listed under FAULT INJECTION SUPPORT entry in MAINTAINERS.
    This is unfortunate, since git-send-email doesn't find emails to send
    the patches to, forcing the user to try to guess who maintains it.
    
    Akinobu Mita seems to be actively maintaining it, so, let's add the file
    under FAULT INJECTION SUPPORT section.
    
    Signed-off-by: Breno Leitao <leitao@debian.org>

diff --git a/MAINTAINERS b/MAINTAINERS
index 0748d6bd0c4f..11f3ef0b5ffd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8388,6 +8388,7 @@ M:	Akinobu Mita <akinobu.mita@gmail.com>
 S:	Supported
 F:	Documentation/fault-injection/
 F:	lib/fault-inject.c
+F:	tools/testing/fault-injection/
 
 FBTFT Framebuffer drivers
 L:	dri-devel@lists.freedesktop.org

