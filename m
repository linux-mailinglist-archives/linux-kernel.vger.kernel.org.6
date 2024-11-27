Return-Path: <linux-kernel+bounces-423384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73C959DA6A5
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 12:15:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1969A161F88
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 11:15:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48B091EF0A3;
	Wed, 27 Nov 2024 11:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="glYm+6+a"
Received: from mail-ed1-f98.google.com (mail-ed1-f98.google.com [209.85.208.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD7281946A1
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 11:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732706121; cv=none; b=Fh7AJoHzzlqBf1iSuA9lYTYkqkK5FF0NYFLlj9S3J6ywcgPpyUwB0i9mJl/5PmjPk6iu78VSOoSpZM9HrhnJjjdOrLDQa4DNkrEb1aVvVAXzHTLR5ZrQfFR1zgmv8JoBpIGfNvfxOwV2s4VjiMMEh7/H4saA+9aJH+d7NmGX7LY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732706121; c=relaxed/simple;
	bh=MK1i4+Rf6RLAmZEH5QQ/XiZ2f2QgQPBtmRAR7/9o92M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=o8gyVtWhT6x1kxgR2TCEiz6WByaC7i1ImCA5G/g4Ts3SXDcYwGBVGbnG/sMzw9RoQKimuUGSPHLIL8JJ2DTO0TujhGb7ZSIetEcMTFR62CVKxzGXwG+46ELDS/pBoDbninD1/tTdqvsixY/RvbIW9hu+/ddDzo5oc+Kpe5G1Lac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com; spf=pass smtp.mailfrom=raspberrypi.com; dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b=glYm+6+a; arc=none smtp.client-ip=209.85.208.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raspberrypi.com
Received: by mail-ed1-f98.google.com with SMTP id 4fb4d7f45d1cf-5cfc035649bso8557088a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 03:15:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1732706118; x=1733310918; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WbwwjTObIrPMKMbgQEUxwz8EAlGUJCffQHwTQcAAqH0=;
        b=glYm+6+aYgPFbz+I+YacK7gEUFBkoxvp6Q0RHZJie9bMAWE7XI+Y2LI7WimYnahIA2
         JWzosLTBum6vQfJnpJrp2/g1p6cdHGRyP5o0sn66FR6Hv1KNmh9/K10RFYnIFMygJsUE
         38uSqm71GrmkIBkoIKPhY4lQYdpM8m7kYZZVzBOD45HMqmFPOQraEgOU5Y1ea8rhaSDH
         s0wNj1eU3FQtZmESi6xQ4wiFjkC0HpqJ9LA4pTa0nzDlJCHOP9q8FmJpnFKAlWvIv9MA
         kgpB/gKyMpzukgG44Xsc7vKaugS32WoX9IVQgWaEPOQ7Py5sddiGudZuKFxei9/AUvsV
         gCug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732706118; x=1733310918;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WbwwjTObIrPMKMbgQEUxwz8EAlGUJCffQHwTQcAAqH0=;
        b=ESCP8yrQFTlp2c6z8Ef0+gQLKrg735pJaK3RCByRad+omIQPjv+1zjDtz8WIWbHE9Q
         kkq0Vkv6Tlx8hEDa+4FN8TF+7y/1VJ1yE8hWg0JmRkbcliqgsECfKtCq20PlsZ81fj4C
         k+d9ln5UIrWOM52vwwvp5jxXgHCKhHdcJyMRJi+7SmsDzwLGy4V0aJk1E+gqwkn/X4aI
         jFWMk19TztUZsEh9OP4b7EUEnrS/Rr3rtTRf97KllkE/qspdua7PLto19AQdzeSR/nVL
         2lVNeeKoja3Z+vWhWUWxPfmZj3VvKy12mEN4bOBNJ/qLHQNg8eBII1EXr+LfzAPejqnF
         Iolw==
X-Forwarded-Encrypted: i=1; AJvYcCXStCJX0W9/j9nH34WHHwj96xpR8SMeleFCKPYDmwR0c7HJ6PYCqfaDp0b0dq9oY9Kee0ZJ2PcthluOQas=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywb4WyvTiMuLvFE+SJT6TIIVhiM/gNDnvw/CTzL+Ifor9y1+YfT
	6nRaHSTZT+DtQdqHewwg5NMOvuvQ2E5kMI4vjcBG3tc/dG5bRlA0xJr9v2nOACPcZzSRRLJAgYZ
	1Gy5Uf0853hUX13MHF/ZFuF1t4yhQw3W0
X-Gm-Gg: ASbGncva0TjsGBoUVmcJT0shOztXcYVxElSGv3Xjqm7GtNJnja8JPWWeQavnIXb904T
	VbonDwzmSh7d5sSd7vPR9YEDYdyzaVvG4X9Lmf0bfe/5a+NR2m6B5o8mceHcE5fJe7hFWGTlRlS
	+auckBwcBq93spCUC05MvVVGuXe/BVoqqSYHw6ujpxezVsIjfsV5E41ArS9KfBndLP6k41Tnmcc
	4wfsP8ajWBli/S5O0NM+Y1goFNODy5Azc73mgax9f0w5ZPWknsPewlzmo+2iO6xzw==
X-Google-Smtp-Source: AGHT+IEhzkon84gktCOU4wQ0YLegpwevnMbIo0lpL/f5tH0yFj51P93r/ssXmdD+9J/oH2WktVzDT4+2hBjv
X-Received: by 2002:a17:906:cc4e:b0:aa5:3982:660f with SMTP id a640c23a62f3a-aa580f57de7mr188391466b.27.1732706117686;
        Wed, 27 Nov 2024 03:15:17 -0800 (PST)
Received: from raspberrypi.com ([93.93.133.154])
        by smtp-relay.gmail.com with ESMTPS id a640c23a62f3a-aa53a1ae8a6sm42110966b.163.2024.11.27.03.15.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 03:15:17 -0800 (PST)
X-Relaying-Domain: raspberrypi.com
From: Naushir Patuck <naush@raspberrypi.com>
To: Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>
Cc: linux-media@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	jacopo.mondi@ideasonboard.com,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	Naushir Patuck <naush@raspberrypi.com>
Subject: [PATCH v2 0/4] media: bcm2835-unicam: Upstreaming various improvements
Date: Wed, 27 Nov 2024 11:15:11 +0000
Message-Id: <20241127111515.565992-1-naush@raspberrypi.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Version 2 of this series has no changes, except patch 5/5 from v1 has been
removed while I rework the logic donwstream first.

Thanks,
Naush

Naushir Patuck (4):
  drivers: media: bcm2835-unicam: Improve frame sequence count handling
  drivers: media: bcm2835-unicam: Allow setting of unpacked formats
  drivers: media: bcm2835-unicam: Disable trigger mode operation
  drivers: media: bcm2835-unicam: Fix for possible dummy buffer overrun

 .../media/platform/broadcom/bcm2835-unicam.c  | 42 ++++++++++++++-----
 1 file changed, 31 insertions(+), 11 deletions(-)

-- 
2.34.1


