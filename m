Return-Path: <linux-kernel+bounces-549099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BFEE6A54D36
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 15:13:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA2253B19CA
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 14:12:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34244156960;
	Thu,  6 Mar 2025 14:12:38 +0000 (UTC)
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF6615383D;
	Thu,  6 Mar 2025 14:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741270357; cv=none; b=eSX/anUKLUmhekQDJYi+CRPQObbNlS4IaVDj3AFu7whPmPQMW7itkKU7XMNflXGhrUTEPROg71L4TTGUH86NpD5C95G8deDdscboQl8Eq2j3KpeM4HbbhiHi0OqVGa2k4ggi+EAXXbm/cm+Dg0l3eKOQD5jd/tWkszhiZYlD6T4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741270357; c=relaxed/simple;
	bh=cLicbPWFnAoD6lUokaPp8hSNzwgqsx9fHiiKE5uzlzw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kPYJw3DbXuagSYVgWcy9aE03o60QXWT8M1yOzQUMiZ1X8c/6pe5N1jHf7HNaH3/BIbY56w6RvaDaoTv7DT9p7dtURemnSRccbErbGfVFDjVrR0ArgPY9gjyp68k1HA34HLQGFIgXo2oh8e7zF64vhX/gt1ep4Lr8vU9JlM1jQDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4750ca77d47so5131761cf.0;
        Thu, 06 Mar 2025 06:12:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741270354; x=1741875154;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9w95l6741tt/4ainrJVSGUVwqtU9mkEIQhAfIpu6hIQ=;
        b=gDiWDN6ylxiYBJcgGmxCQn4vaJt7+QHLxP+ptxQNAbCDWltV7D1WxThRm2Uco5YuPY
         JUfOOdrIhpJUn9K9w5s969E8ZhMyN13z3Lt5FTX7Pi9BEC9v7iKM34LKfx29CfbqkNns
         vWG/zWMFEOPod0/IXbcpbGwiqFIOi2jE1VR35g0tMZNiBXTqZZ19SF3bZLTS6+/GEBIC
         9gtlktBbO4ad/TM75iqETeGCLpkGsgKrnq1iEOh9UnEDF1HY5GMSaWIJ+/tRzqvCKJIm
         wnZrZ4WrMcpWk9ibEoiwqsoSwax/mKgIrXcNcm8aa5JfSsdmY8BCnM3yvqTYTQjT8ldi
         5c6A==
X-Forwarded-Encrypted: i=1; AJvYcCUO0+eqL5wZ6MHWEf4uGb63En8p9VUWHDVaMyHxpOY+iHVLYtpF2xJck+Ytop9ptEcGtuyf2gXhNsDDainH@vger.kernel.org, AJvYcCW/lZBhD4Sud/Lon69pOyV2bywqSw7T1tn6MugHhfKsABWM2aLlRUrf+ZribcCipIWfpQ1wYXUYyWA2@vger.kernel.org
X-Gm-Message-State: AOJu0YypF/SYpQRVeMtXDlJzl1TAANewVMc/1CEzHRsbc0axRODbvcwO
	+NSG91tI5QEIwrt5li0CyS03uaiKKsUd9T8q7gGGL8y+PIL8qRreyoZD/jNG
X-Gm-Gg: ASbGnctDmNVQkO76IhyR+7OHr8uVDmmUV2ym2hUNjC03vsUDek4HBs7rKVb1ywphUCJ
	yMzawDfMyHdD3Qd0bDCyUaYlQ5xM5SwJC2vi+YEPp8hVAwIUUErjWeWw8xyO++plyIMzpjXOuqm
	17xhZzoeR1zPew104/Fn4clZF+zjF/+pjXPueeKmiSiRh24zTSAZECadGhS6EeqX631t+pUP6mP
	Z7hL4H+hbqECb8/R2vDnYaVfhAbiQB5NHyqgv/l/RWNESFvKsdVKw8rFvc8L23cioPjW7JUC1Yn
	spqDRWKnodP0iUzZXKrMD7Zi2bIKuw1X6fkEVvSroXDZumgQON5j6TDHXKbLYWPztxXjG9HB4C4
	8MvEDu76TjFg=
X-Google-Smtp-Source: AGHT+IEaibezR3zts/0tGt24md0yxYzCaCjsy02r+qdlu91DzGebVj5b5HGnvwXbELT+rHT52LO5VA==
X-Received: by 2002:a05:6214:4012:b0:6e8:ad15:e0b9 with SMTP id 6a1803df08f44-6e8e6d34670mr114845576d6.20.1741270354214;
        Thu, 06 Mar 2025 06:12:34 -0800 (PST)
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com. [209.85.160.169])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e8f715bab5sm7443576d6.86.2025.03.06.06.12.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Mar 2025 06:12:33 -0800 (PST)
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4750a85ce4eso5566801cf.2;
        Thu, 06 Mar 2025 06:12:33 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWCPWVOKhBEzc1PKYfolPwpQ65iToRlFZpXxNflTI1wPcw2UVKyeWf3mZ+KxEhQNdBjO31UDCRxpmiBG+e8@vger.kernel.org, AJvYcCXdGMvQoKL+PMY5pTtWTNYw/kMZChAgA0M3MyPlXxQD4XY/Xm81aVRnAMAv9Wooupr6pNaq8Atc3YKq@vger.kernel.org
X-Received: by 2002:a05:6214:5287:b0:6e6:683c:1e32 with SMTP id
 6a1803df08f44-6e8e6cfe364mr103086106d6.8.1741270353722; Thu, 06 Mar 2025
 06:12:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250225210316.3043357-1-robh@kernel.org> <20250225210316.3043357-2-robh@kernel.org>
In-Reply-To: <20250225210316.3043357-2-robh@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 6 Mar 2025 15:12:21 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVuTgOnTw_xXZ23-+RTvPxgQFpMQD=fPgu0CaeP2bQE2Q@mail.gmail.com>
X-Gm-Features: AQ5f1Jp-7DXJEQQeg30O9jhmPV8jIkRv8kW6lNjjvAd7Gsc4GXS7ywNeuGDPxjI
Message-ID: <CAMuHMdVuTgOnTw_xXZ23-+RTvPxgQFpMQD=fPgu0CaeP2bQE2Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] dt-bindings: display: mitsubishi,aa104xd12: Adjust
 allowed and required properties
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	Thierry Reding <thierry.reding@gmail.com>, dri-devel@lists.freedesktop.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 25 Feb 2025 at 22:03, Rob Herring (Arm) <robh@kernel.org> wrote:
> The Mitsubishi aa104xd12 panel requires an external backlight driver
> circuit, so allow the "backlight" property.
>
> There are users of this panel without a vcc-supply, so it shouldn't be
> required.
>
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

