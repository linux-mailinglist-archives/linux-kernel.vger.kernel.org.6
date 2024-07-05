Return-Path: <linux-kernel+bounces-242113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D1CED9283AD
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 10:29:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EB061C24B8C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 08:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E0FA14601D;
	Fri,  5 Jul 2024 08:29:05 +0000 (UTC)
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85DE7145FEC;
	Fri,  5 Jul 2024 08:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720168144; cv=none; b=rxihqXOLuSMB9kwo2B5zWHFOKO3JZpsxHEsTR16WtZgI5xQ2ny2faSlP/9GLBQ7AX8sOfjAe4zJs/BshCS+oPB2w2/r5CJlcuVInrJgVytc8k/iiN5qSS1nSS3tKSnZXyHoX56MF7e+Yvuz8HpIv3GzVyGT2QTZE3fFNKwL1iKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720168144; c=relaxed/simple;
	bh=fGpUvxmXtfZWClBIbkaz5hBOm441yGf8oUjcUM4jUAI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MIrp30fpr2+IcE3/lXgOADoTwJHLS/Ff8oZmrUePWiRA7h++xnPf231CeuKgl9WHJ5ybIe18anTZk2KxP5ICd5vDx1Ks7iFenk+q5Xrx4fN8NKTZ9JE2KdtOWGlRkDglMb9JNBWozXuyKvAZgQjWuk739OHARHVDlYPvwVR2m8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-6504101cfd6so12414497b3.3;
        Fri, 05 Jul 2024 01:29:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720168141; x=1720772941;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m8LN9GumaI9Sqx5EBxRdpNg6j+VJTy86pUG0Z1sQMLk=;
        b=GUZ3vQ4E7VTPY9z/ksQ0znDaIvDOJQBUj75hs76LB8ksXERsYyr6qyubOWmCkkOfdR
         cU9U4y4XxJAKqz7PVx2ZCGCnCpwzCZJTabxP+EalMys4WPyJKy0GK9CkMlWTWxA2Py/g
         5RZmxePSy/IWpkY4JS87pfGdg0FRVXM65klGYMpAAWnslfncDl1O/rWL8gv9NtRLrDG+
         ux3NBl9vfh0WgdF+NMqdrWaQXT1VYCEy6BapjHZbqnxhEjD3V8Kqu/S4onHukXp14mZE
         /cKd+JAbE7gExvqJDfbqnsGMOEfqb7NoV4Q9OGQOHl30tfbniehe2BLKgsv1eT6y0nRf
         kcgA==
X-Forwarded-Encrypted: i=1; AJvYcCU5ZURlvJ3eafa6L5OG+4hBsntK/kjEncj83+kPtYmmypmN6xoEw+mqc21QgvQba4n0izsHYlfPCJLmZX1IwaPU7dyU+ZzMW7PYunTepY2eO4ZyE5UHebZqysZbJAIK2RFVMa+HqRawOQ==
X-Gm-Message-State: AOJu0Yx73GSwnXvCTc4Njg+IKPU5Y13y2fmY5AEX044haUemPxafPqSW
	6SNIUMjKMo5UG/C2aufFrVmDVz3sULC/IT8wKkzLl/YGsILn99jg0iI4/LwO
X-Google-Smtp-Source: AGHT+IELPqcHeD60EGThwVBu+g5L8N+2hVhUFktIm1jYuIRpxCtYMOMuLhlCYG9C+PdVRZNZiOKl5Q==
X-Received: by 2002:a05:690c:25c6:b0:64b:40ff:b972 with SMTP id 00721157ae682-652db2d08e4mr44698597b3.48.1720168141439;
        Fri, 05 Jul 2024 01:29:01 -0700 (PDT)
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com. [209.85.128.177])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-65401345b2asm1584627b3.57.2024.07.05.01.29.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jul 2024 01:29:01 -0700 (PDT)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-6504101cfd6so12414227b3.3;
        Fri, 05 Jul 2024 01:29:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVI3Vl+J/IxDaV+o9iN+J60X4pDBsZ5r4vzU/vpicBCgewwapXtSf23jEdUiGcWAPn6n2l6grfAVSeuWvUliHWhKGgx0M2/TFIl2iJyWZWVgTmM/5pkBvn0srMsa0MVrNMTaMR0diXGAg==
X-Received: by 2002:a81:8453:0:b0:64a:4c2c:f4c2 with SMTP id
 00721157ae682-652d61e9e03mr37877857b3.6.1720168140925; Fri, 05 Jul 2024
 01:29:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240702164403.29067-1-afd@ti.com>
In-Reply-To: <20240702164403.29067-1-afd@ti.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 5 Jul 2024 10:28:49 +0200
X-Gmail-Original-Message-ID: <CAMuHMdX5rcH08ptcdCEJ1UmKa0n_bUH1a6QKcOx2qmhyJG173Q@mail.gmail.com>
Message-ID: <CAMuHMdX5rcH08ptcdCEJ1UmKa0n_bUH1a6QKcOx2qmhyJG173Q@mail.gmail.com>
Subject: Re: [PATCH RFC 0/3] Add generic Overlay for Grove Sunlight Sensor
To: Andrew Davis <afd@ti.com>
Cc: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Andrew Lunn <andrew@lunn.ch>, Vaishnav M A <vaishnav@beagleboard.org>, 
	Derek Kiernan <derek.kiernan@amd.com>, Dragan Cvetic <dragan.cvetic@amd.com>, 
	Arnd Bergmann <arnd@arndb.de>, Michael Walle <mwalle@kernel.org>, 
	Jason Kridner <jkridner@beagleboard.org>, Robert Nelson <robertcnelson@beagleboard.org>, 
	Robert Nelson <robertcnelson@gmail.com>, Ayush Singh <ayush@beagleboard.org>, 
	Ayush Singh <ayushdevel1325@gmail.com>, linux-arm-kernel@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

Thanks for your series!

On Tue, Jul 2, 2024 at 6:45=E2=80=AFPM Andrew Davis <afd@ti.com> wrote:
> So what does this all look like? Let's take an example of a BeaglePlay
> with two Grove connectors for which we have physically attached a
> Sunlight module to the first connector, and an Air Quality sensor to
> the second. Doing ahead of time command-line DT overlay application:
>
> ./fdtoverlay \
>         -o output.dtb \
>         -i k3-am625-beagleplay.dtb
>                 k3-am625-beagleplay-grove-connector0.dtbo grove-sunlight-=
sensor.dtbo \
>                 k3-am625-beagleplay-grove-connector1.dtbo grove-air-quali=
ty.dtbo
>
> We start with the base board, then apply the adapter overlay for the
> specific connector we are going to attach the add-on. The next add-on
> overlay applied will attach to the connector most recently applied.
> This can be continued as needed, simply apply the next connector's
> adapter overlay, then the next add-on, rinse, repeat.

Oh, that's a neat trick, eliminating the need to enhance fdtoverlay
and friends with support for translating anchors while applying.

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

