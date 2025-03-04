Return-Path: <linux-kernel+bounces-543609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D0A6AA4D77E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 10:09:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B57DE188C6F1
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 09:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A5371FCCEB;
	Tue,  4 Mar 2025 09:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="HoZUHGFH"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1605D1EA7CE
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 09:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741078845; cv=none; b=RtAKQcHcUl946wSRNarDmu4Id+REa8tFIQEvt8SzknSmQ2Y93sv62dk/0bjv5jvMypyWrUQBoyWeWpZy4bd8uJYIXuabgk4Dp+CUj0esH5Jvh+w5K9KoPmx7ycDk1rXwT6UNkr5EeTBx/Fp0EIS73hLp1n8eOCqWzivq9cmlvdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741078845; c=relaxed/simple;
	bh=C5ZHUydAfD7qIPC2fugkdbL/7ZQbv9+E48hf7fmVHuI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZBNBW+OqiD8xEWYxc+mNbGz1Y6ZAfYhuHHFGOYW272FBHrxCKY1lOkLZCBWKd+dfwHAG9CBvWLVnA1ax4k0qUu6uhj+ZKxFqN0PPYG/Liyr1hhy8wQ/61n60+/05b5OcKHm7FECTcbZz9tS6emt24D2sHMWgsFQLN566Y64ONAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=HoZUHGFH; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43948f77f1aso34642335e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 01:00:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1741078842; x=1741683642; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5UP7DmGMGEllBfFdaot9026+FUs+6/ByI4Mfm7p9ZUY=;
        b=HoZUHGFH3Y3FTWhwkHDQQUy4JseQKHJd+NaXAIQ5OId1VHbF6srGTfUWL4YPG9UU6t
         9OuRn+3XADWpRHOI/g7l9J+52arW586qdZvgBhfCMBlaE0P4Y32HnL9A55y/kA/LygU2
         QLAFLzP+hw15qhUlx+v7gJXMXdycytGcpQy3cMiEwrSVjnlKCur0jKKGoJ/Bmh5RvL72
         wCukzIqEB8iZTsvvm/H0yy1enT8OrcBWc9UGcVK7h+05c3b5r2TmsUSH5H9t6K4yJrHf
         V+rHcKmRSsU7DWv/JJMNRxnl5SRe8seaabn8A3pcz4DXhK6XPoG68ge2jV0iqLSG7fXI
         YyTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741078842; x=1741683642;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5UP7DmGMGEllBfFdaot9026+FUs+6/ByI4Mfm7p9ZUY=;
        b=T+i708+VGeXYdZazrcN6hy4UxXd4s0UH9C5FpqRyaPFSbda8X6x0POhKuPUebTQGOU
         b292BfIHOHB2q4/GWCP6LsZFM6/sxslFM3VPytcp5eANh78oNIe5QGYozGnNUANnmI06
         yQDKFFXwekcUzECRnPO64gj85NYaZjpp9/irEBMPzJDmmi0HXBtOMlNdGAlhuy7y1II+
         qOKZ1u/atXjFo4Pr4qZ2PN7V3fPEIiSLCrZ8OHKCQy8MwTv2xkFxo7UKqMo8JA7YUxF5
         RfMfxXHaB+QibSfdi5Ux827TC6JQ6Txz2ezk+m7s8hYRiDnv51yjf63WsfoRC+lQJoOr
         u+tg==
X-Forwarded-Encrypted: i=1; AJvYcCUSROT+cH6n1U4v23yuAPqP3Ept//9+bmfUdI7SJH3zyBnFZn7pgTuJERP5uPMJWztHJ1YRTfGGypojmgA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKBEal1mB3w2bp+m231qY/iXVZGLEKiy50DF/2X3ra2KZcu6o7
	Rp0m+E9zBKsDgPEMmlFnmxepT5w5lCijqiYD2pd7P4ULQOkbwbKgo7ar+FcQBXA=
X-Gm-Gg: ASbGnctKXiwZwvNEYaZfoiljzISKykDcB++9S0/TZPErgqI88CfBtRyD3JL+zC4JJaE
	AUzyyFIRvwFcseLTqy2oQ7ffgCbb850nv8lGm+4sVmTIl/Qep36f4OBZpgDCqSJM9bdhh7HEIkX
	h6fgYdLnRofktMfAWhOqpcVi5oEKkw8nHuOEkyLHjHXN6F6e8uv8ojyy7y7UGZBlwFuVFlqA5UA
	3mIiGRKB3SIqE2qLANbDWP8FJ1m/ZNnA+EX03w7QbudXgrgFr6kHy53A7T/bVtBSN5PRoM+YMyU
	xom/MCMEvmKjmPxkJO47bP89x3WPHymI
X-Google-Smtp-Source: AGHT+IE98Wtw/qck2RNdbUy35iBZdcuCmo9BHlXLPhcqJEgVkq5LxR8GTapjzExbGuStv6PALsyUfQ==
X-Received: by 2002:a05:600c:3b23:b0:439:98b0:f8ce with SMTP id 5b1f17b1804b1-43ba66e60f5mr143195855e9.7.1741078842210;
        Tue, 04 Mar 2025 01:00:42 -0800 (PST)
Received: from localhost ([2a02:8308:a00c:e200::688c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bbf2edf84sm75715855e9.40.2025.03.04.01.00.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 01:00:41 -0800 (PST)
Date: Tue, 4 Mar 2025 10:00:41 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: Atish Patra <atishp@rivosinc.com>
Cc: Anup Patel <anup@brainfault.org>, Atish Patra <atishp@atishpatra.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, kvm@vger.kernel.org, 
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 4/4] KVM: riscv: selftests: Allow number of interrupts
 to be configurable
Message-ID: <20250304-bb96798e9a1fd292430df3e8@orel>
References: <20250303-kvm_pmu_improve-v2-0-41d177e45929@rivosinc.com>
 <20250303-kvm_pmu_improve-v2-4-41d177e45929@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250303-kvm_pmu_improve-v2-4-41d177e45929@rivosinc.com>

On Mon, Mar 03, 2025 at 02:53:09PM -0800, Atish Patra wrote:
> It is helpful to vary the number of the LCOFI interrupts generated
> by the overflow test. Allow additional argument for overflow test
> to accommodate that. It can be easily cross-validated with
> /proc/interrupts output in the host.
> 
> Signed-off-by: Atish Patra <atishp@rivosinc.com>
> ---
>  tools/testing/selftests/kvm/riscv/sbi_pmu_test.c | 38 +++++++++++++++++++-----
>  1 file changed, 31 insertions(+), 7 deletions(-)
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

