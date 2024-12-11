Return-Path: <linux-kernel+bounces-441262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6101F9ECC05
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 13:25:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B5EE280C71
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 12:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB7D6225A4B;
	Wed, 11 Dec 2024 12:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Px5/bFL9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F451AF0D8;
	Wed, 11 Dec 2024 12:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733919946; cv=none; b=KkV/H06YJnvFUc7pTN+5l3Qys4BAQvnVGe7j+xZxA7YPAoB8UyNJYObWGTO/QHw6lww5QlgEdbgeWPzMAomxxg3HhJlWqN271UwM7o6JeZ0fGzsS+H1bVlEUgS/7dK+O4OWEagcaWtG/MulGOPtIFsOpJMLmb7ibYC1ExZMRK/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733919946; c=relaxed/simple;
	bh=KXFMRN/pnEc5WpAO05w2dauo90eSyioOBFOtPz/2KCI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=nDF7jhkXqMRY0Lizf2AelQzWK3bC7Wto+2KZmF/cpaZOBhIN1pt5S4luSxd4f/Yl8mPFkdyaLJMGLAlo22uJQsJpttIplNYX9fhyH58k63+KKClzuKHlFVC0dSCSg7mD1wdORa4GEKXmpzyTb9hBntpIgJOM3F1zjTetZ9m2qzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Px5/bFL9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 396F0C4CED2;
	Wed, 11 Dec 2024 12:25:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733919945;
	bh=KXFMRN/pnEc5WpAO05w2dauo90eSyioOBFOtPz/2KCI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Px5/bFL9JW1WtpQnj/MKT/vow0GA8+7j9VMHJW5J3Mw5jbEqHuHz4KweKSqQYn8J7
	 Q7WVMCbv699UNTe8p9IPKdefnHSjKz2t95Nd3dkN9byuaH4Ci1KYzxeUJ6RuA3CTvd
	 J4uyK2NpTnrQsVjKAguom+6g2P2lpACfzEnwhD+qXicKBIBiL9Bg+fcG5ooV5hrRIU
	 Q8MJ990f2CGFnBKnnkS+aMYXzoEPsU0orl3cd/h1ZmDMRQP4GjO+svny0V+oSmz7oP
	 sO52/Nh85VfOgpO2GtNcgKlVch1BzNE48deESnabQnp+0sBZIsKIU0NbXuLNYsrwKB
	 nnj8AmrPqg8Jg==
From: Lee Jones <lee@kernel.org>
To: Andy Shevchenko <andy@kernel.org>, Peter Tyser <ptyser@xes-inc.com>, 
 Lee Jones <lee@kernel.org>, Hans de Goede <hdegoede@redhat.com>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241114193808.110132-1-hdegoede@redhat.com>
References: <20241114193808.110132-1-hdegoede@redhat.com>
Subject: Re: (subset) [PATCH] mfd: lpc_ich: Add another Gemini Lake ISA
 bridge PCI device-id
Message-Id: <173391994391.782805.17939045533438701407.b4-ty@kernel.org>
Date: Wed, 11 Dec 2024 12:25:43 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.13.0

On Thu, 14 Nov 2024 20:38:08 +0100, Hans de Goede wrote:
> On N4100 / N4120 Gemini Lake SoCs the ISA bridge PCI device-id is 31e8
> rather the 3197 found on e.g. the N4000 / N4020.
> 
> While at fix the existing GLK PCI-id table entry breaking the table
> being sorted by device-id.
> 
> 
> [...]

Applied, thanks!

[1/1] mfd: lpc_ich: Add another Gemini Lake ISA bridge PCI device-id
      commit: 49339c4af2adcf9e9d080fcf751723d3ba52fe50

--
Lee Jones [李琼斯]


