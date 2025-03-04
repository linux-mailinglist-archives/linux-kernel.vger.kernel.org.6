Return-Path: <linux-kernel+bounces-545538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 75AB3A4EE4E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 21:26:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4F941890A24
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 20:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97AA524C691;
	Tue,  4 Mar 2025 20:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TyR8ZiH4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05EF17DA93;
	Tue,  4 Mar 2025 20:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741120001; cv=none; b=Mm/mxaJDgk36ijOMt0gHHLHpbY/Mfm5qMeJtdmqH6HvHao+fe8Fp9wZvtpCsj4Qx+deasZEJLXVvBny8cZWmETAY1vBRIHpMmYkI7sdq1IcUuSQNUXciAOVO+8ai7mO0oY/mdMpZHFyPRNxGrqWTOIilkYZYnh83VS6f9BBjUak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741120001; c=relaxed/simple;
	bh=O/0n0R6wlWD9uCCCZ9LQoHF8bwvGqznu+uTuNyQJ2D4=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=A2jCZLIxTK6yKTtu/QTs8xoOhA/zSiEge+yor/4U+flGVIJWPk8fqRUBb46ICfAswlzes8MGRp7ii55Zaix3hVwoM2NVEVKFbG2wtJwnjWXxIBxtOIuyiI9h1HkGtU3NhL6g886QS2NbnQVNhmspNuO6yA0gmB8mbvpwapJUhPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TyR8ZiH4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54873C4CEE5;
	Tue,  4 Mar 2025 20:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741120000;
	bh=O/0n0R6wlWD9uCCCZ9LQoHF8bwvGqznu+uTuNyQJ2D4=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=TyR8ZiH4qaAMhfK8wTRoArl1mVO1abWPLdx9HNby9eaXVaTp6dY/iCYrH52EzNxb+
	 jbOMm1fmM8fllQzHCVG2sOzYI1wDBywMQCNxTgDONaaAHt61BvZJ4goetjal4GGJZ6
	 VZYvHDI6c1NCvbz2VRhpqs8rIg7LW5PZ79Qd5scxbqZNPAbsrRQavW16+EqFXecowH
	 AfUoDn1wqrWKVIcFx2gdyQnRXG8X+D5JN8nJIYMoXJ4RNCsaom5ZpC2EsyceoUDA6U
	 DScScbDoDdtc1ocTKdpQRR70K+1x8WBIBAVgf/yHW4MEjxPg3kQJrXu1mHrNhBM1an
	 AweNSN7NdcTZA==
Date: Tue, 4 Mar 2025 21:26:37 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: Wentao Guan <guanwentao@uniontech.com>
cc: bentiss@kernel.org, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: i2c-hid: improve i2c_hid_get_report error message
In-Reply-To: <20250214110418.16000-1-guanwentao@uniontech.com>
Message-ID: <89p3r354-r3q0-r684-oq86-46o47rro0q76@xreary.bet>
References: <20250214110418.16000-1-guanwentao@uniontech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 14 Feb 2025, Wentao Guan wrote:

> We have two places to print "failed to set a report to ...",
> use "get a report from" instead of "set a report to", it makes
> people who knows less about the module to know where the error
> happened.
> 
> Before:
> i2c_hid_acpi i2c-FTSC1000:00: failed to set a report to device: -11
> 
> After:
> i2c_hid_acpi i2c-FTSC1000:00: failed to get a report from device: -11
> 
> Signed-off-by: Wentao Guan <guanwentao@uniontech.com>

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs


