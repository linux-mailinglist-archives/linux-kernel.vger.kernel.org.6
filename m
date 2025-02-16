Return-Path: <linux-kernel+bounces-516501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05C41A3729A
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 09:40:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77FC616E3D9
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 08:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EBA21624E0;
	Sun, 16 Feb 2025 08:40:06 +0000 (UTC)
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF94158DD9;
	Sun, 16 Feb 2025 08:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739695206; cv=none; b=paD9Pp4SXNbxjyPBXObeo3hXPjXMT5/8+DM4IoxsFCu7wMOsDPh0Fu1TBMUMHUEEhQ8pV0P4ieCr9Ad8gnO8bhrvqCNBDyt5j4pJ+Xb0j/TTs1VGomaClfs32Nx1GbZP/x3N+x7CtT400UBpcMd94nBIzjhMZ4bscJcIHHyAkg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739695206; c=relaxed/simple;
	bh=wXpKHX0ZasccCQS/rRdK60+YV5wRpbezRfa/+sNSrQ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MzU/6RWD2z8pnSxWk7RPvn858W+xe8DXet1Bu/hhTFSQ9a3fovqQhQnsl3suInmEyIw4MMp3TssgAu6yujJQsTklzmMMB2JJww3jAhp3giCOOXULVWyXaTOoUhtSbpf2FLYeJ4YgsRzmlPX6hK2msy2gyrIomx42dHxqpCyHwg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-8556adad825so256006239f.0;
        Sun, 16 Feb 2025 00:40:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739695199; x=1740299999;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wXpKHX0ZasccCQS/rRdK60+YV5wRpbezRfa/+sNSrQ4=;
        b=kNuyrP+NlqOdvijCTyZl+u69ZzFN2Tfbl6f3idv5NPf4upZiFeT7b3lhyX45FWfzE4
         x06WGpPPRp0Z/MpnEm4DMfhkj2r7m99BZxrwvN5+k17XKcgypGE1+Q/RB4YcfEi+NdsY
         XA+fegQoOAYf1XHVcLzaxvdudNUCQsOCypybyyq7L/qBo/dUDL7ULLQEqUEawalpGBqS
         FKeV8shE6DgQHshRTMfTsaIMV6ETdvIjJ1ELAdBgdrtlv4FiMMYSJ+AKcjfv+UXPK5Sj
         vOVBi7WeTUeV4zdgtfSthppA/uSN2kTWo1DSjTBSQkGQ/Z3i/p83xAATyKLmPUEzMziQ
         B6Ww==
X-Forwarded-Encrypted: i=1; AJvYcCUfBz5zL6ovu7zUaLvcPoUF/SElS5abxRwYQfAuvlBISL6lqe4jBqctSacvZYNIflQ3LYH2PpMXz9vLdkbQ@vger.kernel.org, AJvYcCWAthcN0hcVfDkU0J3YLJfiBbwSwBAzRUlkzZQeko01XTRXl4zK0ZbcZ4JQDIdzsWhiGhRJVA9QD2hh@vger.kernel.org, AJvYcCWFmlBLqsfoKKba2bHaWQDaw8GsRGm1zYrE6KlfhPzRbuPgJ5LAgR5Vzrk49W49xEEXBbDuk5oEM6BD@vger.kernel.org
X-Gm-Message-State: AOJu0YwNHOxsW1P1tV5O3m2KxOyBAQzlqqaqSWLshSnSpkrDrHnW2wEH
	mVknZNhkfQx71J1JR9aELaR6rMtqOZvWNAJgmoDKI8K+Og69eEngmvmtH9FUrHQ=
X-Gm-Gg: ASbGncvHYIGK5fhrUcbPc+irH8PLxUswHcjzNzFyGM6M4kCvzT5K3zfEoDAq+/zqRHg
	7x0OtFIQtYJCQ0N9Ai6Ytm0TNc2ZA+GSmzObaBj6uCC+f5HvxRGW9b4ANEx0gwjjHk7CLb9MaAP
	KlP+tGAVefM9iOJWz5i0OQzpbnGc8eDaXscbl95QL+yhU9QOSr8yORlMZL+d1AzIXO8aVla0btk
	FB0LywzJQIbOrPQhTYk2lxIZzTd3Bs9rEYuVh307pO32UpGbiuE+nvME1N7JAQNqKs5EQsTUJXH
	SDH/JvL92Nu3cymc7MltrgeUHzPjA1pYZ0UyMOCBVs/p3aHF
X-Google-Smtp-Source: AGHT+IE2/9CMRNnb6IAS3VLAXcGBduUipI0k1btZ79Y/8RgTabSY+KGZ4QBtJj1jYXWDBwK9wzWyqg==
X-Received: by 2002:a05:6602:1541:b0:855:6c15:d8a9 with SMTP id ca18e2360f4ac-8557a10ee94mr427530239f.8.1739695198863;
        Sun, 16 Feb 2025 00:39:58 -0800 (PST)
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com. [209.85.166.180])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ed281491f5sm1610837173.29.2025.02.16.00.39.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Feb 2025 00:39:57 -0800 (PST)
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3d0465a8d34so29782425ab.0;
        Sun, 16 Feb 2025 00:39:57 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUpvwjII32UtUhpwt4/qQdU8yjlfSe6medJsHyp8Xn1sK8GrCpxvXiH69hij7aCXxC7XTk8Cyc4IpaJ@vger.kernel.org, AJvYcCWg+G/fONoiaOUb29SMAXH8J3ECau5TocPk9AwAEPWLYp6NbzpIC5oB+VELVD6d/ok4nw9mgLGu/YbI@vger.kernel.org, AJvYcCXMspnVSMNmZb+7YfEx6Zg6PiGuLFVVa7mqTG2cXEjZxP3LGAzcv7z+oNRggOl58xbXaN9JjKGdj63hnYWN@vger.kernel.org
X-Received: by 2002:a05:6e02:3182:b0:3d1:8ab7:9569 with SMTP id
 e9e14a558f8ab-3d279685dacmr46970125ab.0.1739695197464; Sun, 16 Feb 2025
 00:39:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250214125359.5204-1-andre.przywara@arm.com> <20250214125359.5204-3-andre.przywara@arm.com>
In-Reply-To: <20250214125359.5204-3-andre.przywara@arm.com>
Reply-To: wens@csie.org
From: Chen-Yu Tsai <wens@csie.org>
Date: Sun, 16 Feb 2025 16:39:38 +0800
X-Gmail-Original-Message-ID: <CAGb2v67JF-NBLG8GBnReHvczKXgiKBYHTR15HTCtspGcWTK5ag@mail.gmail.com>
X-Gm-Features: AWEUYZnAYxHy4jgtgA_B5U0mMvfm0UP2fVTcNC4hjtdhMTuDWPQD0C_dkfISXeo
Message-ID: <CAGb2v67JF-NBLG8GBnReHvczKXgiKBYHTR15HTCtspGcWTK5ag@mail.gmail.com>
Subject: Re: [PATCH v2 02/15] clk: sunxi-ng: mp: introduce dual-divider clock
To: Andre Przywara <andre.przywara@arm.com>
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, linux-clk@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 14, 2025 at 8:56=E2=80=AFPM Andre Przywara <andre.przywara@arm.=
com> wrote:
>
> The Allwinner A523 SoC introduces some new MP-style mod clock, where the
> second "P" divider is an actual numerical divider value, and not the
> numbers of bits to shift (1..32 instead of 1,2,4,8).
> The rest of the clock is the same as the existing MP clock, so enhance th=
e
> existing code to accommodate for this.
>
> Introduce the new CCU feature bit CCU_FEATURE_DUAL_DIV to mark an MP
> clock as having two dividers, and change the dividing and encoding code
> to differentiate the two cases.
>
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>

