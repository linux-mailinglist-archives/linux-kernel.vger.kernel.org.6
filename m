Return-Path: <linux-kernel+bounces-236412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FF0091E1E1
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 16:08:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C342B241FD
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 14:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77C1816079B;
	Mon,  1 Jul 2024 14:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="TkGOGG4Q"
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 615DC160781
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 14:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719842923; cv=none; b=MEra7apb9rEgJE3dyZI01WRZBhF4bQhdFbLvcRUJx4YLDuw9Gz7BgsgDmuqBsjI6kXikPEa1dFXXD4qcbU56TGXzskIuOpFMCMEwANARFLY4gliLW8ZmCNuidQtzlGtM0iyFyAThWrNrfLmlPx5B338GnOiQvyfE5nkb1NMjSEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719842923; c=relaxed/simple;
	bh=cUGu0W7I/KO8EJpQL3/SOGRCJMKWN69nHxvWVGGD4UE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eF+FhHffBopRh/Y5/8o6Sf403UPwiiNYl9vN3DUqVJ5XXutbuXqj9T3Cd6Mfuquq5xqZJMnfQfSqK0OXyay1igapQ7uSlzROdKa7665Qr8NVLzuxVgLMVbUB1AOqa/VzwyXEv35VLLyWV6Oydia3NcwjA7UahV1u1lTpauL3zik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=TkGOGG4Q; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-445033fbc24so26631511cf.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 07:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1719842921; x=1720447721; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=V3CGRdltZKLEzMTcWHE0HXKapnqnAMbIbhtY4sNi32Y=;
        b=TkGOGG4Q6DRuVTNOk1mXAgJIShN7dGqYVpNWmIdZdsbTeUHwEQHpYf8p1K0hKcvS23
         qvUyHlHYY9pU3FUGBfoZV4BPIh+AGEpgqYIcoZDqhL3+ISt15t+VfZX3jZ3oGcZ7mq/u
         Cxd4be7HeJfu12cr3jXvYAhDtpkiYnZH+yGyjdUIL+c+Nh13mRYbROAVcdys2HSwY76v
         l0LCzod/5X3xkK1PIISuVPGffWH4vfEjiYziDzlm2AYRWZ9Ro3kqb44Pv0R26lEl7qmt
         7/ODVtMQbFVSS1qJlplfpPYzSWw9Ukw2V7ELmLZcP0gYgfFCi7FZzWkC3Gq4lLWrqQDM
         99RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719842921; x=1720447721;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V3CGRdltZKLEzMTcWHE0HXKapnqnAMbIbhtY4sNi32Y=;
        b=pXJmX98vvBVVsfVlV3IvhhxRr5vUwqDsdJdBXV3IzPpGRGYJZUt1HOqQ0bHpLemTBW
         t0hInIbEOSjFPAp6BZgTMzCGtv5y26q4nHExwuRe+CpMlN2X8EOe7hLz0UJNfCLN8en2
         EGY0sYPuW3pUO5wCLvtalmneLM0i0JwQlEXT+SZorTZiCOFj20q8fkahTNsOUXPycVYM
         FmFIQFROtjN98QHlxYpd+56hMg4/mr+2+qdt1umQ60m4Bc5aaIQeO2YDCeW9h+/5nSjz
         yxzrY7b2/G86U7BUxKNXohp3Kwqq260Sk/pupPykh6nxh5MeUHM+mTjZKWJK/XSb0QF3
         ZXuw==
X-Forwarded-Encrypted: i=1; AJvYcCX64Q65h06OYTMc8ER26CFBLaN7lWM7fPAGeJ1tQtYo+OlGIp3EbXp6GjTzHtfAUkMxZS52jnT4V+2RwfWcu7PX4VkWaoNhh/f13Lwq
X-Gm-Message-State: AOJu0YyGt792yLcvVopHXT03A6Mq0YujgN3GUjtlI1UUW5aMxebLoIh0
	i0Opb6xX7PWYeUQG1pqF67geFdHtNIilVtI2sLDjNg6TinqBrZ7hWSjgzCU3ibc=
X-Google-Smtp-Source: AGHT+IHmIxQz7e2tkxFUxh6n9heUT9VPRsYDhw3zonhXK/TfgobKQNp9ohD09a1u8+kPDFPtUpBhwQ==
X-Received: by 2002:ad4:5d68:0:b0:6b4:f6f6:98c with SMTP id 6a1803df08f44-6b5b704f9aamr79758416d6.13.1719842921179;
        Mon, 01 Jul 2024 07:08:41 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b59e36849csm33439746d6.4.2024.07.01.07.08.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 07:08:40 -0700 (PDT)
Date: Mon, 1 Jul 2024 10:08:40 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Johannes Thumshirn <jth@kernel.org>
Cc: Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH v3 3/5] btrfs: stripe-tree: add selftests
Message-ID: <20240701140840.GG504479@perftesting>
References: <20240701-b4-rst-updates-v3-0-e0437e1e04a6@kernel.org>
 <20240701-b4-rst-updates-v3-3-e0437e1e04a6@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240701-b4-rst-updates-v3-3-e0437e1e04a6@kernel.org>

On Mon, Jul 01, 2024 at 12:25:17PM +0200, Johannes Thumshirn wrote:
> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> 
> Add self-tests for the RAID stripe tree code.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

These tests run the code, but don't validate that the end result is what we
expect, that should be added.  Thanks,

Josef

