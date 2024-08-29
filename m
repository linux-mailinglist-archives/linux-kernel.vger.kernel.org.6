Return-Path: <linux-kernel+bounces-306859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4E6B9644AF
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 14:37:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D52BB26DAC
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 12:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFA651A76D2;
	Thu, 29 Aug 2024 12:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XV9yBhyO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 142B31991A3
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 12:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724934844; cv=none; b=R85M48EODXVe7TIKdcuo0483pfplMcT+vpaYpc4wgXJxEJYyv+ZolpcIWMaAYxQwIGF+FG1juPWS9BU7U3BntU66kFBK66ypTncqWY5O5FJTWN9akxOO1LN4ZBDj+kHhv4T7uhs/4NEN2gm0KzJNho3fIrOHrCyq1fr9pdDQ6HY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724934844; c=relaxed/simple;
	bh=gjx472YUEMEfeW+BANZlSDN0gpzlxGYmnR4JGKIGUc0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=D3aHJV5MHCfUUIsijptChzHQNcAPJ3CKBzMIX7WtgtMliPZdoYxJSViwXMQhuI6g3jCIs/4luq9JVlWC8B2sa4kdAqI7/hah0DcCFv4TJwVk/Fq2E7svQJV2qVrJ70WhROsDPTzoBr9ZJL6yvjiDtdQwE3RMEQW5JWxv9SfUy+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XV9yBhyO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C502CC4CEC1;
	Thu, 29 Aug 2024 12:34:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724934843;
	bh=gjx472YUEMEfeW+BANZlSDN0gpzlxGYmnR4JGKIGUc0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=XV9yBhyOd6mKv07QAQi+IgHyC/o7lPm+PmyJN/4c92SeBwiCL6Z0DxJjZUtcJZJFv
	 JeJ4CtOElmd9wonMvFa8mK7Q1hpqaaomzYsIoZqAl5uZ+o0d9nuA4a2iDIh08e+Q1L
	 wZ4LsiZQt1RmXaVxLjneyb2YVpRZ64jEFup4I/H3zY22wHyrfC5fwilG3DKFzkWx5O
	 k9jK4I0a8C+rKPL6bIZcE4G8UepWPOg4pAWQ5b5ZHAdHOW6l7T9dgerB4+CEM/I0fd
	 5Fqsij1qkVsFx0/4BPaIbyeNUYTWjuS0qBvYrfwJs6TkVfk2kVaB5yV+mNPgPHsIgE
	 x4xHz6DQPcGBQ==
From: Lee Jones <lee@kernel.org>
To: Andy Shevchenko <andy@kernel.org>, Lee Jones <lee@kernel.org>, 
 Hans de Goede <hdegoede@redhat.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20240825132617.8809-1-hdegoede@redhat.com>
References: <20240825132617.8809-1-hdegoede@redhat.com>
Subject: Re: (subset) [PATCH] mfd: intel_soc_pmic_chtwc: Make Lenovo Yoga
 Tab 3 X90F DMI match less strict
Message-Id: <172493484252.4011760.11050701389935546017.b4-ty@kernel.org>
Date: Thu, 29 Aug 2024 13:34:02 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.13.0

On Sun, 25 Aug 2024 15:26:17 +0200, Hans de Goede wrote:
> There are 2G and 4G RAM versions of the Lenovo Yoga Tab 3 X90F and it
> turns out that the 2G version has a DMI product name of
> "CHERRYVIEW D1 PLATFORM" where as the 4G version has
> "CHERRYVIEW C0 PLATFORM". The sys-vendor + product-version check are
> unique enough that the product-name check is not necessary.
> 
> Drop the product-name check so that the existing DMI match for the 4G
> RAM version also matches the 2G RAM version.
> 
> [...]

Applied, thanks!

[1/1] mfd: intel_soc_pmic_chtwc: Make Lenovo Yoga Tab 3 X90F DMI match less strict
      commit: daf72a9fa64105e213db6e99e62bc03e2dc2e8b5

--
Lee Jones [李琼斯]


