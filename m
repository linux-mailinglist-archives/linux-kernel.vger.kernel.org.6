Return-Path: <linux-kernel+bounces-514000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CB1CA35130
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 23:25:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39C3F7A1A3E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 22:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7026026E146;
	Thu, 13 Feb 2025 22:25:04 +0000 (UTC)
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED2F19DF61
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 22:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739485504; cv=none; b=ix0NS55r3uVGFSPCi3+PwF+EYMzApwK9w0Zj0zKwo+dStOESzo7Rif81o5vYbtdpqL8ItyvZCPy5mNHyrTtySeCsa3M+KgrWLwx97n+y/wGDVjnBZi+h20aEd6KpCzh9GiktV7wV1NLDql4nwtPsJoD5G+UJFb1aPgYyeKUjK30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739485504; c=relaxed/simple;
	bh=tX+C05GeUE87TqUH9cMtFWQ1CguSjuFwr5dfBDNawcc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Xo1rNzF4G1LJn7tPF9YX9KfOeitWzYVoXR3+7g/mX9/Bg8U2XwjGw9JcfSGokXT7ipFm1/TdfolXmZnuUXPvr2O78priWGl9jOXHANqkzOr6D/p0du5DPge2YjHXdn7VCc96z8IdqP/ONtdi9twyt1tQz4Mrdf8IdbXJ4N6FNz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=uejji.net; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=uejji.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-726f989dc12so755795a34.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 14:25:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739485501; x=1740090301;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ILoYyziuUnuJVlSgfSskon+uaaNzPS6ou+QE/PEWzVQ=;
        b=s7AUkg5atxqsVz7MQqFSxq2CyOb+Yd6nN4gSA9QkDYBeUEbB3GvqbtCUD7gAEmzK6f
         +eHcTwHGzi1yKx9myqgKLEhduFAWLJGn/iGZqz6vbciLo/2uY+f9WNzUHF1XWrfT6Ezp
         Ws1KpopNw3Q1/RZuIaPwd64VoSSiC9tu0Oc6mJ4xpmYDIVX7bFuCMuvniesFWW/pZqGW
         jY7lbnOx2/jv2F/MJAieAktCREm2c4hphIbPSLjuK5HeL9dIsjhub0UAWyoxC3TNk/Cx
         KslUymMxHTQMDVdOFbYql5E/n16tUGEVuHf/xmRodBOqH4JKfV0V+y1P4FrvoI94l00N
         Z8Aw==
X-Forwarded-Encrypted: i=1; AJvYcCWCtVYsCCw75D28DlcdNTx5k8aY8jl5SWZf+tRoszpMjAY1BgKkXLKjdmUTNV7PgCne1Q5sEAHsXOTqjsI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDyKY88MOkzxjcE9K2E7t6Ajj8a+LfWOo3YX7hdyZ3/3clU14f
	frtTQpcD/3mkHAkykG0L18+i0Lht3OdJgr5NC0hKUmY1TT5aQKAn
X-Gm-Gg: ASbGncsytBiRVoOv0rhqAg6NacFLV2QOTTDV1v26Se3b8MVoWFCgXrH9v7TkBmmWYTU
	rz3MdM2rm5jyVj7T1cIhmdc9+siCfZFqsb1UdUXCsfbuexgyPZH06ALVG5EMw81Ch2gCRtWmSnD
	5KRSlHZgnohQ1rOgAJWGDnVdlmyRnsrN+jqqTemU/p8ZI1IiRnX3j0r5jtgRbnK1bgv/FZmsjA3
	nxxFJis1I6GQNjlBuyGKgsGW48GKnl7GLMwQ9VR+168n5mXj/DVXObNEDeiZzD4B7fIHGnlz+Mg
	YF9cHH2h8kuZAWU7
X-Google-Smtp-Source: AGHT+IHVHjm3jW5M4b4UU7lCiPVHL6mmwLCaKdUPLs7cl2wGNyM005lh9F/qHiFSQOQuLf2UkwQLqA==
X-Received: by 2002:a05:6830:6e97:b0:726:d36a:3ed0 with SMTP id 46e09a7af769-726fe75a5dcmr2991891a34.5.1739485501314;
        Thu, 13 Feb 2025 14:25:01 -0800 (PST)
Received: from muster.uejji.net ([47.188.205.107])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-727001cde00sm984184a34.5.2025.02.13.14.24.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 14:25:00 -0800 (PST)
From: John Edwards <uejji@uejji.net>
To: Hans de Goede <hdegoede@redhat.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Cc: John Edwards <uejji@uejji.net>,
	Andrew Wyatt <fewtarius@steamfork.org>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/5] Handheld gaming PC panel orientation quirks
Date: Thu, 13 Feb 2025 22:24:48 +0000
Message-ID: <20250213222455.93533-1-uejji@uejji.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello.

I am submitting a small number of patches to add panel rotation quirks for
a few handheld gaming PCs.  These patches were created by the SteamFork
team and are in daily use by us and/or members of our community.

The following devices are covered by these patches:
1: AYANEO 2S
2: AYANEO Flip DS, AYANEO Flip KB
3: AYANEO Slide, Antec Core HS
4: GPD Win 2 (with correct DMI strings)
5: OneXPlayer Mini (Intel)

Thank you for your consideration and for taking the time to review these
patches.

John Edwards

v3:
- Correct indentation errors in Flip DS/KB and Slide patches
- Include Reviewed-by tags for Thomas Zimmermann and Hans de Goede

v2:
- Minor rewording of commit messages
- Include Tested-by tag for Paco Avelar in AYANEO Flip DS/KB patch
- Add OneXPlayer Mini (Intel) patch
https://lore.kernel.org/dri-devel/20250124204648.56989-2-uejji@uejji.net/

v1:
https://lore.kernel.org/dri-devel/20250116155049.39647-2-uejji@uejji.net/

Andrew Wyatt (5):
  drm: panel-orientation-quirks: Add support for AYANEO 2S
  drm: panel-orientation-quirks: Add quirks for AYA NEO Flip DS and KB
  drm: panel-orientation-quirks: Add quirk for AYA NEO Slide
  drm: panel-orientation-quirks: Add new quirk for GPD Win 2
  drm: panel-orientation-quirks: Add quirk for OneXPlayer Mini (Intel)

 .../gpu/drm/drm_panel_orientation_quirks.c    | 40 ++++++++++++++++++-
 1 file changed, 38 insertions(+), 2 deletions(-)

-- 
2.43.0


